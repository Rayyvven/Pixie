extends Button

@onready var video_dialog: FileDialog = $"../../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/Video/VideoDialog"
@onready var file_dialog: FileDialog = $"../../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/SongFileDialog"
@onready var pause_menu: Control = %PauseMenu
@export var scene_loading = false
var scene_path = ""
var time_elapsed = 0.0
var scene_to_be_loaded = ""
signal scene_loaded

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
	var Config = ConfigFile.new()
	print("New ConfigFile")

	var err = Config.load("user://SavedLevels.cfg")
	#if err != OK:
	#	return
	if LevelController.LevelData["Level Info"]["ID"] == -1:
		LevelController.LevelData["Level Info"]["ID"] = len(Config.get_sections())
		Config.set_value(str(len(Config.get_sections())), "Level", LevelController.LevelData)
	else:
		Config.set_value(str(LevelController.LevelData["Level Info"]["ID"]), "Level", LevelController.LevelData)
	print("Set Value")
	Config.save("user://SavedLevels.cfg")
	
	DirAccess.make_dir_absolute("user://music")
	var audio = file_dialog.get_current_path()
	if not "/pixie/" in audio:
		print("FileDialog: ", file_dialog.get_current_path())
		var file_name = audio.get_file()
		var source_file = FileAccess.open(audio, FileAccess.READ)
		print("Audio: ", audio)
		print("SourceFile: ", source_file)
		var path = "user://music/" + file_name
		var file = FileAccess.open(path, FileAccess.WRITE_READ)
		var data = source_file.get_buffer(source_file.get_length())
		file.store_buffer(data)
	else:
		print("Skipping file creation process, file already saved!")
	## Video Saving
	DirAccess.make_dir_absolute("user://video")
	var video = video_dialog.get_current_path()
	if not "/pixie/" in video:
		print("VideoDialog: ", video_dialog.get_current_path())
		var video_name = video.get_file()
		var source_video = FileAccess.open(video, FileAccess.READ)
		print("Video: ", video)
		print("Source Video: ", source_video)
		var VidPath = "user://video/" + video_name
		var VidFile = FileAccess.open(VidPath, FileAccess.WRITE_READ)
		var VidData = source_video.get_buffer(source_video.get_length())
		VidFile.store_buffer(VidData)
	else:
		print("Skipping video creation, already saved")

	Load_Scene("res://Scenes/editor_levels.tscn")
	pause_menu.visible = false
