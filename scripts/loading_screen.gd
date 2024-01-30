extends Control

@onready var percentage_button = $PercentageButton
@onready var progress_bar = $ProgressBar

var progress = []
var scene_name
var scene_load_status = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_name = "res://scenes/world.tscn"
	ResourceLoader.load_threaded_request(scene_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_name, progress)
	percentage_button.text = str(floor(progress[0]*100)) + "%"
	progress_bar.value = progress[0] * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(scene_name)
		get_tree().change_scene_to_packed(new_scene)
