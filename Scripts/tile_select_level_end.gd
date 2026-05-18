extends TextureButton


func _process(delta: float) -> void:
	if SelectedTile.TileSelect == 4:
		modulate.r = 0.5
		modulate.g = 0.5
		modulate.b = 0.5
		button_pressed = true
	else:
		modulate.r = 1
		modulate.g = 1
		modulate.b = 1
		button_pressed = false

func _on_toggled(toggled_on: bool) -> void:
	print("Toggled")
	if toggled_on:
		modulate.r = 0.75
		modulate.g = 0.75
		modulate.b = 0.75
		SelectedTile.TileSelect = 4
	else:
		modulate.r = 1
		modulate.g = 1
		modulate.b = 1
