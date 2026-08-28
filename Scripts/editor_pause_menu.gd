extends TextureButton

@onready var pause_menu: Control = %PauseMenu
@onready var options_menu: Control = %OptionsMenu
@onready var music: AudioStreamPlayer = $"../../Music"
@onready var tile_select: TextureButton = $"../TileSelect"
@onready var editor_pause: TextureButton = $"."

func _on_pressed() -> void:
	if pause_menu.visible == false:
		disabled = true
		editor_pause.mouse_filter = 2
		pause_menu.visible = true
		options_menu.visible = false
		music.bus = "MenuMusic"
		EditorOptionsGlobal.Shown = true ## Temporary?
		if tile_select.tog == true:
			tile_select.pressed.emit()
	else:
		pause_menu.visible = false
		music.bus = "LevelMusic"
		EditorOptionsGlobal.Shown = false

func _on_unpause_pressed() -> void:
	editor_pause.disabled = false
	editor_pause.mouse_filter = 0
	pause_menu.visible = false
	music.bus = "LevelMusic"
	EditorOptionsGlobal.Shown = false
