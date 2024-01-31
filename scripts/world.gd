extends Node3D

@onready var pause_menu = $PauseMenu
@onready var resume_button = $PauseMenu/Panel/VBoxContainer/ResumeButton
@onready var globals = get_node("/root/Globals")
var paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	globals.current_scene = "res://scenes/world.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		resume_button.grab_focus()
		pause_menu.show()

	paused = !paused
