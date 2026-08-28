extends TextureButton

@onready var canvas_layer: CanvasLayer = $"../.."
@onready var pause_menu: Control = %PauseMenu

func _on_pressed() -> void:
	print("Options Toggled")
	var OptionsMenu = preload("uid://rx3yg8kvrsic").instantiate()
	pause_menu.add_child(OptionsMenu)


func _on_tile_id_toggled(toggled_on: bool) -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	Options.set_value("Editor", "ShowTileIDs", true)
	Options.save("user://options.cfg")
