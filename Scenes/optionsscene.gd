extends Control
### This will be essentially the new main options script, rather than having multiple scripts
### on a per-button basis. Cheers

func SaveToOptions(Category: String, Option: String, Value):
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	if err != 0: print("err: ", err)
	Options.set_value(Category, Option, Value)
	Options.save("user://options.cfg")
	print_rich("[color=green]Updated CFG with ", Category, " ",  Option, " ", Value)
	
func _ready() -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	if err != 0: print("err: ", err)
	print("Options Categories: ", len(Options.get_sections()))
	if len(Options.get_sections()) == 0:
		print("Initial Launch, creating values in CFG file...")
		Options.set_value("Global", "MusicVolume", 0)
		Options.set_value("Global", "SFXVolume", 0)
		Options.set_value("Global", "Framerate", 0)
		Options.set_value("Global", "Vsync", 0)
		Options.set_value("Global", "Window", 0)
		Options.set_value("Global", "Graphics", 0)
		Options.set_value("Editor", "FollowSyncBar", false)
		Options.set_value("Editor", "SmoothDrag", true)
		Options.set_value("Editor", "SnapX", true)
		Options.set_value("Editor", "SnapY", true)
		Options.set_value("Editor", "SnapBPM", false)
		Options.set_value("Editor", "UpdatedRowCalculation", false)
		Options.set_value("Editor", "ScrollStrength", 50)
		Options.set_value("Editor", "BackgroundBlur", 0)
		Options.set_value("Editor", "ShowTileIDs", false)
		Options.save("user://options.cfg")


func _on_music_volume_value_changed(value: float) -> void:
	SaveToOptions("Global", "MusicVolume", value)
