extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Editor", "SmoothDrag", toggled_on)
	Options.save("user://options.cfg")
