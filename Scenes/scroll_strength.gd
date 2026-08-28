extends LineEdit



func _on_text_changed(new_text: String) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Editor", "ScrollStrength", int(new_text))
	Options.save("user://options.cfg")
