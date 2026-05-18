extends TextureButton
@onready var pause_menu: Panel = $PauseMenu


func _on_pressed() -> void:
	if pause_menu.visible:
		pause_menu.visible = false
	else:
		pause_menu.visible = true
