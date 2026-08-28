extends Button

@onready var file_dialog: FileDialog = $"../../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/SongFileDialog"
@onready var video_dialog: FileDialog = $"../../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/Video/VideoDialog"

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
	## Music Saving
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
