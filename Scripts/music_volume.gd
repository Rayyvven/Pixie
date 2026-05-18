extends HSlider

func _on_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(3, value)
	AudioServer.set_bus_volume_db(2, value)
	print("Changed Music Volume: ", value)
