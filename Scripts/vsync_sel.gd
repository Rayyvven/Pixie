extends OptionButton

func _on_item_selected(index: int) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Global", "Vsync", index)
	var VsyncOpt = [DisplayServer.VSYNC_ENABLED, DisplayServer.VSYNC_DISABLED, DisplayServer.VSYNC_ADAPTIVE, DisplayServer.VSYNC_MAILBOX]
	DisplayServer.window_set_vsync_mode(VsyncOpt[Options.get_value("Global", "Vsync")])
	Options.save("user://options.cfg")
