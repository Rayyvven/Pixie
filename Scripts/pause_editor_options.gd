extends TextureButton
@onready var editor_pause_options: ColorRect = $EditorPauseOptions
@onready var editor_pause_menu: Node2D = $EditorPauseMenu



func _on_pressed() -> void:
	if editor_pause_menu.visible == false:
		editor_pause_menu.visible = true
	else:
		editor_pause_menu.visible = false
