extends Label
@onready var file_dialog: FileDialog = $"../FileDialog"
signal LoadedSong
@onready var music: AudioStreamPlayer2D = $"../../../../AudioStreamPlayer2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_file_dialog_file_selected(path: String) -> void:
	if file_dialog.get_current_path():
		text = "Song File: \n" + file_dialog.get_current_file()
		var stream = AudioStreamMP3.new()
		var file = FileAccess.open(path, FileAccess.READ) ## This is stupid
		stream.data = file.get_buffer(file.get_length())
		music.stream = stream
		print("Loaded file ", file_dialog.get_current_file())
		LoadedSong.emit()
		LevelController.LevelData["Level Info"]["SongFile"] = file_dialog.get_current_file()
	else:
		text = "Song File:\nN/A"
