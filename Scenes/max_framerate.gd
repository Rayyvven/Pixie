extends LineEdit



func _on_text_submitted(new_text: String) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Global", "Framerate", new_text)
	Engine.max_fps = int(new_text)
	Options.save("user://options.cfg")
