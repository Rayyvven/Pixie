extends LineEdit


func _on_text_submitted(new_text: String) -> void:
	LevelController.LevelData["Level Info"]["Artist"] = new_text
