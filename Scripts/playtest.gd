extends Button
@onready var speed_val: LineEdit = $"../../../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@export var scene_loading = false
var time_elapsed = 0.0
signal scene_loaded
var scene_to_be_loaded = ""
var scene_path = ""

func Load_Scene(scene : String):
	scene_path = scene
	time_elapsed = Time.get_ticks_msec()
	ResourceLoader.load_threaded_request(scene_path)
	scene_loading = true

func _process(delta: float) -> void:
	if scene_loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			print_rich("[color=pink]Loading Progress: %s" % (progress[0]*100))
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			scene_to_be_loaded = ResourceLoader.load_threaded_get(scene_path)
			print_rich("[color=pink]Loading Progress: %s" % (progress[0]*100))
			time_elapsed = Time.get_ticks_msec() - time_elapsed
			print(time_elapsed)
			scene_loading = false
			scene_loaded.emit()

func _on_scene_loaded() -> void:
	get_tree().change_scene_to_packed(scene_to_be_loaded)

func _on_pressed() -> void:
	Load_Scene("res://Scenes/playtest.tscn")
	LevelController.LevelData["Level Info"]["Speed"] = speed_val.text ## HOPEFULLY provides a last-minute fix. I still just have no fucking clue why this doesn't work
