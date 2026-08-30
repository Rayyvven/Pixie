extends Panel


func _ready() -> void:
	#await get_tree().create_timer(.05).timeout
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	if err != 0: print("err:", err)
	
	$OptionsVBox/MusicVolumeHBox/MusicVolume.value = Options.get_value("Global", "MusicVolume")
	$OptionsVBox/SFXVolumeHBox/SFXVolume.value = Options.get_value("Global", "SFXVolume")
	$OptionsVBox/VideoOptionsHbox/MaxFramerate.text = str(Options.get_value("Global", "Framerate"))
	$OptionsVBox/VideoOptionsHbox/VsyncSel.selected = Options.get_value("Global", "Vsync")
	$OptionsVBox/VideoOptionsHbox/Window.selected = Options.get_value("Global", "Window")
	$OptionsVBox/VideoOptionsHbox/Graphics.selected = Options.get_value("Global", "Graphics")
	$OptionsVBox/EditorHbox/FollowSyncBar.button_pressed = Options.get_value("Editor", "FollowSyncBar")
	$OptionsVBox/EditorHbox/SmoothDrag.button_pressed = Options.get_value("Editor", "SmoothDrag")
	$OptionsVBox/EditorHbox2/SnapY.button_pressed = Options.get_value("Editor", "SnapY")
	$OptionsVBox/EditorHbox/SnapX.button_pressed = Options.get_value("Editor", "SnapX")
	$OptionsVBox/EditorHbox2/ScrollStrength.text = str(Options.get_value("Editor", "ScrollStrength"))
	$OptionsVBox/EditorHbox2/BackgroundBlur.value = Options.get_value("Editor", "BackgroundBlur")
	$OptionsVBox/ExperimentalHBox/SnapBPM.button_pressed = Options.get_value("Editor", "SnapBPM")
	$OptionsVBox/ExperimentalHBox/UpdatedRowCalculation.button_pressed = Options.get_value("Editor", "UpdatedRowCalculation")

	var VsyncOpt = [DisplayServer.VSYNC_ENABLED, DisplayServer.VSYNC_DISABLED, DisplayServer.VSYNC_ADAPTIVE, DisplayServer.VSYNC_MAILBOX]
	DisplayServer.window_set_vsync_mode(VsyncOpt[Options.get_value("Global", "Vsync")])


func _on_button_pressed() -> void:
	$"..".queue_free()
