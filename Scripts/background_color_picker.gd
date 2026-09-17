extends ColorPicker

func _on_color_changed(color: Color) -> void:
	LevelController.LevelData["Level Info"]["BackgroundColor"] = color

func _ready() -> void:
	color = LevelController.LevelData["Level Info"]["BackgroundColor"]
