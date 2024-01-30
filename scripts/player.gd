extends VehicleBody3D

const MAX_STEER = 0.8
const ENGINE_POWER = 500

var parking_brake = false

@onready var camera_pivot = $CameraPivot
@onready var camera_3d = $CameraPivot/Camera3D
@onready var reverse_camera = $CameraPivot/ReverseCamera
@onready var top_camera = $CameraPivot/Camera3D/SubViewportContainer/SubViewport/TopCamera
@onready var speed_counter = $SpeedText/SpeedCounter

var nlook_at
var initial_transform
var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	nlook_at = global_position
	initial_transform = transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_handle_parking_brake()
	if Input.is_action_pressed("reset"):
		global_position = Vector3.ZERO
		global_transform = initial_transform
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	else:
		steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 1)
		engine_force = Input.get_axis("down", "up") * ENGINE_POWER
		speed = int(linear_velocity.length())
		speed_counter.text = str(speed)
	_handle_camera(delta)

func _handle_camera(delta):
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	top_camera.global_position = global_position + Vector3(0, 100, 0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 2.0)
	nlook_at = nlook_at.lerp(global_position + linear_velocity, delta * 2.0)
	camera_3d.look_at(nlook_at)
	reverse_camera.look_at(nlook_at)
	_check_camera_swtich()
	
func _check_camera_swtich():
	if linear_velocity.dot(transform.basis.z) > -5:
		camera_3d.current = true
	else:
		reverse_camera.current = true
		
func _handle_parking_brake():
	if Input.is_action_pressed("brake"):
		Input.start_joy_vibration(0,1,1,0)
		set_brake(50)
	elif get_brake() == 50:
		Input.stop_joy_vibration(0)
		set_brake(0)
