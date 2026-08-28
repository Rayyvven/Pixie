extends Button

@onready var accept_dialog: AcceptDialog = $AcceptDialog

func _on_accept_dialog_confirmed() -> void:
	OS.shell_open("https://github.com/Rayyvven/Pixie/wiki/Editor")

func _on_pressed() -> void:
	accept_dialog.visible = true
