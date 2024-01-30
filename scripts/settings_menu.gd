extends Control

@onready var back_button = $Panel/BackButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if back_button.button_pressed:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
