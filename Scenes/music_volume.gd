extends HSlider

func _on_drag_ended(value_changed: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	AudioServer.set_bus_volume_db(3, value)
	AudioServer.set_bus_volume_db(2, value)
