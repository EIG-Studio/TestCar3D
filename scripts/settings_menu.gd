extends Control

@onready var back_button = $Panel/BackButton
@onready var resolution_menu = $Panel/VBoxContainer/ResolutionMenu
@onready var fullscreen_check_box = $Panel/VBoxContainer/FullscreenCheckBox
@onready var globals = get_node("/root/Globals")

var default_resolution

# Called when the node enters the scene tree for the first time.
func _ready():
	resolution_menu.grab_focus()
	add_items()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if back_button.button_pressed or Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(globals.current_scene)

func add_items():
	default_resolution = get_window().size
	resolution_menu.add_item(str(get_window().size.x) + "x" + str(get_window().size.y))
	resolution_menu.add_separator()
	resolution_menu.add_item("1024x546")
	resolution_menu.add_item("1280x720")
	resolution_menu.add_item("1600x900")
	resolution_menu.add_item("1920x1080")
	resolution_menu.add_item("2560x1440")
	resolution_menu.add_item("3840x2160")


func _on_resolution_menu_item_selected(index):
	var current_selected = index
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	fullscreen_check_box.button_pressed = false
	if current_selected == 0:
		get_window().size = default_resolution
	if current_selected == 2:
		get_window().size = Vector2i(1024,546)
	if current_selected == 3:
		get_window().size = Vector2i(1280,720)
	if current_selected == 4:
		get_window().size = Vector2i(1600,900)
	if current_selected == 5:
		get_window().size = Vector2i(1920,1080)
	if current_selected == 6:
		get_window().size = Vector2i(2560,1440)
	if current_selected == 7:
		get_window().size = Vector2i(3840,2160)

func _on_check_box_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolution_menu.selected = 0
