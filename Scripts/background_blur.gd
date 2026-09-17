extends HSlider


func _on_drag_ended(value_changed: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Editor", "BackgroundBlur", value)
	Options.save("user://options.cfg")
