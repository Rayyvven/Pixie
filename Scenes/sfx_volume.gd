extends HSlider

func _on_drag_ended(value_changed: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	print("Dragged")
	Options.set_value("Global", "SFXVolume", value)
	if value == -72.0:
		AudioServer.set_bus_mute(1, true)

	else:
		AudioServer.set_bus_mute(1, false)
		AudioServer.set_bus_volume_db(1, value)
	Options.save("user://options.cfg")
