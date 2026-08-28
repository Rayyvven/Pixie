extends LineEdit

func _on_text_changed(new_text: String) -> void:
	LevelController.LevelData["Level Info"]["Song"] = new_text
