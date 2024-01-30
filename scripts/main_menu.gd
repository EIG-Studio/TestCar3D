extends Control

@onready var play_button = $VBoxContainer/PlayButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var exit = $VBoxContainer/Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if exit.button_pressed:
		get_tree().quit()
	elif settings_button.button_pressed:
		get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")
	elif play_button.button_pressed:
		get_tree().change_scene_to_file("res://scenes/loading_screen.tscn")
