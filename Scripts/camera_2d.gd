extends Camera2D
@onready var options_menu: Node2D = %OptionsMenu
@onready var pause_menu: Node2D = %PauseMenu
@onready var play: TextureButton = $Play
@onready var play_position: Button = $"../PlayPosition"

@onready var sync_bar_follow: CheckButton = $EditorPause/PauseMenu/PauseEditorOptions/EditorPauseMenu/EditorPauseOptions/SyncBarFollow

func _process(delta: float) -> void:
	if options_menu.visible == false and pause_menu.visible == false:
		position.y = %VScrollBar.value
		if sync_bar_follow.button_pressed == true and play.Speed != 0:
			position.y = play_position.position.y - 720
			%VScrollBar.value = position.y
