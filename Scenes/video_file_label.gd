extends Label
@onready var file_dialog: FileDialog = $"../FileDialogVideo"

@onready var video: VideoStreamPlayer = $"../../../../ColorRect/VideoStreamPlayer"

signal LoadedVideo
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
