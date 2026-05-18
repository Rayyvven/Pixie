extends HSlider

func _on_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(1, value)
	print("Changed SFX Volume: ", value)
