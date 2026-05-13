extends TextureButton
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
var Shown : bool = false
@onready var pause_menu: Node2D = %PauseMenu
@onready var tile_select: TextureButton = $"../TileSelect"

func _on_toggled(toggled_on: bool) -> void:
	if $OptionsMenu.visible == false:
		$OptionsMenu.visible = true
		pause_menu.visible = false
		music.bus = "MenuMusic"
		EditorOptionsGlobal.Shown = true
		print(Shown)
		if tile_select.tog == true:
			tile_select.button_down.emit()
	else:
		$OptionsMenu.visible = false
		music.bus = "LevelMusic"
		EditorOptionsGlobal.Shown = false
		print(Shown)
