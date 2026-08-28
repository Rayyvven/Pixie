extends TextureButton
@onready var t: TextureButton = $"."
@onready var import_file: FileDialog = $ImportFile

func _on_import_file_dir_selected(dir: String) -> void:
	print("Selected Directory: ", dir)
	var json = JSON.new()
	var file = FileAccess.open(dir + "//LevelData.json", FileAccess.READ)
	var TFile = file.get_as_text()
	var dict = JSON.parse_string(TFile)
	print("File Dict: ", dict)
	
	var Config = ConfigFile.new()
	var err = Config.load("user://SavedLevels.cfg")
	if err != OK:
		print("Error")
		return
	var NewID = len(Config.get_sections())
	dict["Level Info"]["ID"] = NewID
	print(dict["Level Info"]["ID"])
	Config.set_value(str(NewID), "Level", dict)
	get_tree().reload_current_scene()
	Config.save("user://SavedLevels.cfg")
	## Get Song
		
	DirAccess.make_dir_absolute("user://music")
	var audio = dict["Level Info"]["Song"]
	if not "/pixie/" in audio:
		print("FileDialog: ", dict["Level Info"]["Song"])
		var file_name = audio.get_file()
		var source_file = FileAccess.open(audio, FileAccess.READ)
		print("Audio: ", audio)
		print("SourceFile: ", source_file)
		var path = "user://music/" + file_name
		var MusicFile = FileAccess.open(path, FileAccess.WRITE_READ)
		var data = source_file.get_buffer(source_file.get_length())
		MusicFile.store_buffer(data)
	else:
		print("Skipping file creation process, file already saved!")
	## Video Saving
	DirAccess.make_dir_absolute("user://video")
	var video = dict["Level Info"]["VideoFile"]
	if not "/pixie/" in video and not video == "N/A":
		print("VideoDialog: ", dict["Level Info"]["VideoFile"])
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
	
func _on_pressed() -> void:
	print("Importing Track...")
	import_file.visible = true
	## Open file explorer
	## Get folder
	## Get LevelData.JSON
	## Temp variable
	## Get ID, update it such that it is the biggest ID
	## Get song, place song in user://music
	## Imported Track color?
var tween := Tween.new()
func _on_mouse_entered() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(t, "scale", Vector2(1.1, 1.1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(t, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
