extends ThemedTextureButton

@export var ID: int
@onready var s: TextureButton = $"."
@onready var level_name: LineEdit = $"../LevelName"

func _on_pressed() -> void:
	var Config = ConfigFile.new()
	
	var err = Config.load("user://SavedLevels.cfg")
	if err != OK:
		return
	LevelController.LevelData = LevelController.DefaultLevelData ## Fallback
	LevelController.LevelData = Config.get_value(level_name.text, "Level")
	Load.LoadScene("res://Scenes/editor.tscn")
