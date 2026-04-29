extends Label
@onready var file_dialog: FileDialog = $"../FileDialog"
@onready var music: AudioStreamPlayer2D = $"../../../../AudioStreamPlayer2D"
# Called when the node enters the scene tree for the first time.



func _on_song_file_label_loaded_song() -> void:
	print("Getting Length...")
	var length = music.stream.get_length()
	length = round(length)
	text = "Length: \n" + str(length)
	print("Length set to ", length)
	if length == 0.0:
		print("oopsies")
		text = "Well shit"
