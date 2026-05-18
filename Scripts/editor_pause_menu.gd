extends TextureButton
@onready var pause_menu: Node2D = %PauseMenu
@onready var options_menu: Node2D = %OptionsMenu
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var tile_select: TextureButton = $"../TileSelect"


func _on_pressed() -> void:
	if pause_menu.visible == false:
		pause_menu.visible = true
		options_menu.visible = false
		music.bus = "MenuMusic"
		EditorOptionsGlobal.Shown = true ## Temporary?
		if tile_select.tog == true:
			tile_select.button_down.emit()
	else:
		pause_menu.visible = false
		music.bus = "LevelMusic"
		EditorOptionsGlobal.Shown = false


func _on_unpause_pressed() -> void:
	pause_menu.visible = false
	music.bus = "LevelMusic"
	EditorOptionsGlobal.Shown = false
