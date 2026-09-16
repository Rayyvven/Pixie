extends Button
@onready var speed_val: LineEdit = $"../../../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
func _on_pressed() -> void:
	Load.LoadScene("res://Scenes/playtest.tscn")
	LevelController.LevelData["Level Info"]["Speed"] = speed_val.text ## HOPEFULLY provides a last-minute fix. I still just have no fucking clue why this doesn't work
