extends TextureButton
@onready var options_menu: Control = %OptionsMenu
@onready var row_control: LineEdit = $"../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/RowControl"
@onready var tile_select: TextureButton = $"../../TileSelect"
@onready var music: AudioStreamPlayer = $"../../../Music"
@onready var pause_menu: Control = %PauseMenu
var Shown : bool = false

func _on_toggled(toggled_on: bool) -> void:
	if options_menu.visible == false:
		options_menu.visible = true
		pause_menu.visible = false
		music.bus = "MenuMusic"
		EditorOptionsGlobal.Shown = true
		print(Shown)
		if tile_select.tog == true:
			tile_select.pressed.emit()
		var Options = ConfigFile.new()
		var err = Options.load("user://options.cfg")
		if Options.get_value("Editor", "UpdatedRowCalculation") == true:
			row_control.visible = true
		else:
			row_control.visible = false
	else:
		options_menu.visible = false
		music.bus = "LevelMusic"
		EditorOptionsGlobal.Shown = false
		print(Shown)
