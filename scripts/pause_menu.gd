extends Control

@onready var world = $"../"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_resume_button_pressed():
	world.pauseMenu()


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
