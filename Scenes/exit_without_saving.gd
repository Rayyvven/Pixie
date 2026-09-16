extends Button
@onready var exit_dialog: ConfirmationDialog = $ExitDialog
@onready var pause_menu: Control = %PauseMenu

func _on_pressed() -> void:
	exit_dialog.visible = true

func _on_exit_dialog_confirmed() -> void:
	LevelController.LevelData = LevelController.DefaultLevelData
	Load.LoadScene("res://Scenes/editor_levels.tscn")
	pause_menu.visible = false
