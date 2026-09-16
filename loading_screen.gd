extends Control
@export var scene_loading = false
@onready var loading_blur: ColorRect = $CanvasLayer/LoadingBlur

@export var progress: Array
var time_elapsed = 0.0
signal scene_loaded
var scene_to_be_loaded = ""
var Path = ""
func LoadScene(PathToScene: String) -> void:
	get_tree().change_scene_to_file("res://loading_screen.tscn")
	Path = PathToScene
	time_elapsed = Time.get_ticks_msec()
	ResourceLoader.load_threaded_request(Path)
	scene_loading = true
	
func _process(delta: float) -> void:
	if scene_loading:
		progress = []
		var status = ResourceLoader.load_threaded_get_status(Path, progress)

		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			scene_to_be_loaded = ResourceLoader.load_threaded_get(Path)
			print_rich("[color=pink]Loading Progress: %s" % (progress[0]*100))
			time_elapsed = Time.get_ticks_msec() - time_elapsed
			print(time_elapsed)
			scene_loading = false
			get_tree().change_scene_to_packed(scene_to_be_loaded)
			print("Good evning")
