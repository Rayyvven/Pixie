extends Button

@onready var video_dialog: FileDialog = $VideoDialog
@onready var video_label: Label = $VideoLabel
@onready var background_video: VideoStreamPlayer = $"../../../../../../BackgroundControl/BackgroundVideo"
@onready var video: Button = $"."

func _on_pressed() -> void:
	video_dialog.visible = true

func _on_video_dialog_file_selected(path: String) -> void:
	video.text = "Video File: \n" + video_dialog.get_current_file()
	background_video.set_stream(load(path))
	print("Loaded ", path)
	#background_video.play()
	LevelController.LevelData["Level Info"]["VideoFile"] = video_dialog.get_current_file()
	print(LevelController.LevelData["Level Info"]["VideoFile"])
