extends TextEdit

func _on_text_changed() -> void:
	LevelController.LevelData["Level Info"]["Description"] = text
