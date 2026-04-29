extends TextureButton


func _on_toggled(toggled_on: bool) -> void:
	print("Toggled")
	if toggled_on:
		modulate.r = 0.75
		modulate.g = 0.75
		modulate.b = 0.75
	else:
		modulate.r = 1
		modulate.g = 1
		modulate.b = 1
