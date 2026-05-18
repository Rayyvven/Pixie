extends Label
@onready var file_dialog: FileDialog = $"../FileDialog"
@onready var music: AudioStreamPlayer2D = $"../../../../AudioStreamPlayer2D"
@export var length = 0.0
@onready var length_label: Label = $"."
func _on_song_file_label_loaded_song() -> void:
	print("Getting Length...")
	length_label.length = music.stream.get_length()
	length_label.length = round(length)
	text = "Length: \n" + str(length)
	print("Length set to ", length)
	if length == 0.0:
		print("oopsies")
		text = "Well shit"
