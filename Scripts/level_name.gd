extends LineEdit

func _on_text_changed(new_text: String) -> void:
	LevelController.LevelData["Level Info"]["Name"] = new_text
	print("Saved Level name as ", new_text)
