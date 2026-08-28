extends Button
@onready var song_file_dialog: FileDialog = $SongFileDialog

func _on_button_down() -> void:
	if song_file_dialog.visible == false:
		song_file_dialog.visible = true
	else:
		song_file_dialog.visible = false
