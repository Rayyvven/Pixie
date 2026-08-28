extends Camera2D
@onready var options_menu: Control = %OptionsMenu
@onready var pause_menu: Control = %PauseMenu
@onready var play: TextureButton = $"../Yikes/Play"
@onready var play_position: Button = $"../../PlayPosition"
@onready var sync_bar_follow: CheckButton = $"../PauseMenu/PauseEditorOptions/EditorPauseMenu/EditorPauseSettingsPanel/VBoxContainer/Row 1/SyncBarFollow"
var Options = ConfigFile.new()
var err = Options.load("user://options.cfg")
func _process(delta: float) -> void:
	if options_menu.visible == false and pause_menu.visible == false:
		position.y = %VScrollBar.value
		if Options.get_value("Editor", "FollowSyncBar") == true and play.Speed != 0:
			position.y = play_position.position.y - 720
			%VScrollBar.value = position.y
