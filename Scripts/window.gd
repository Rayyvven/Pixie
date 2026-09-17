extends OptionButton

func _on_item_selected(index: int) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Global", "Window", index)
	DisplayServer.window_set_mode(index)
	Options.save("user://options.cfg")
