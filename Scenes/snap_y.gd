extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Editor", "SnapY", toggled_on)
	Options.save("user://options.cfg")

func _on_snap_x_toggled(toggled_on: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Editor", "SnapX", toggled_on)
	Options.save("user://options.cfg")
