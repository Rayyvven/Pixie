extends OptionButton

func _on_item_selected(index: int) -> void:
	LevelController.LevelData["Level Info"]["Difficulty"] = index
