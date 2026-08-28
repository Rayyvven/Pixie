extends Button

func _on_pressed() -> void:
	$ResetDialog.visible = true

func _on_reset_dialog_confirmed() -> void:
	print("Resetting Track...")
	LevelController.LevelData = LevelController.DefaultLevelData
	print("Reset LevelController.LevelData")
	LevelController.SavedLevelData = {}
	print("Reset LevelController.SavedLevelData")
	print("Reloading scene...")
	get_tree().reload_current_scene()
