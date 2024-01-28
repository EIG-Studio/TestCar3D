extends VehicleBody3D

const MAX_STEER = 0.8
const ENGINE_POWER = 300

var parking_brake = false

@onready var camera_pivot = $CameraPivot
@onready var camera_3d = $CameraPivot/Camera3D
@onready var reverse_camera = $CameraPivot/ReverseCamera

var nlook_at
var initial_transform

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	nlook_at = global_position
	initial_transform = transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("brake"):
		linear_velocity = linear_velocity.lerp(Vector3.ZERO, delta * 1.0)
	elif Input.is_action_pressed("reset"):
		global_position = Vector3.ZERO
		global_transform = initial_transform
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	else:
		steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 5.0)
		engine_force = Input.get_axis("down", "up") * ENGINE_POWER

	# Camera
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	nlook_at = nlook_at.lerp(global_position + linear_velocity, delta * 5.0)
	camera_3d.look_at(nlook_at)
	reverse_camera.look_at(nlook_at)
	_check_camera_swtich()

func _check_camera_swtich():
	if linear_velocity.dot(transform.basis.z) > -5:
		camera_3d.current = true
	else:
		reverse_camera.current = true
