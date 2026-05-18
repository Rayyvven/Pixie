extends Label
@onready var file_dialog: FileDialog = $"../FileDialog"
signal LoadedSong
@onready var music: AudioStreamPlayer2D = $"../../../../AudioStreamPlayer2D"
@onready var length_label: Label = $"../Length Label"

func _ready() -> void:
	text = "Song File: \n" + music.stream.resource_path
	length_label.length = music.stream.get_length()
	length_label.length = round(length_label.length)
	length_label.text = "Length: \n" + str(length_label.length)
	print("Length set to ", length_label.length)
	if length_label.length == 0.0:
		print("oopsies")
		text = "Well shit"

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
		LevelController.LevelData["Level Info"]["Song"] = file_dialog.current_path
	else:
		text = "Song File:\nN/A"
