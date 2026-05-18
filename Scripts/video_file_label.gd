extends Label
@onready var file_dialog: FileDialog = $"../FileDialogVideo"

@onready var video: VideoStreamPlayer = $"../../../../ColorRect/VideoStreamPlayer"

signal LoadedVideo



func _on_file_dialog_file_selected(path: String) -> void:
	if file_dialog.get_current_path():
		text = "Video File: \n" + file_dialog.get_current_file()
		var stream = VideoStreamPlayer.new()
		var file = FileAccess.open(path, FileAccess.READ) ## This is stupid
		
		video.stream = stream
		print("Loaded file ", file_dialog.get_current_file())
		LoadedVideo.emit()
	else:
		text = "Video File:\nN/A"
