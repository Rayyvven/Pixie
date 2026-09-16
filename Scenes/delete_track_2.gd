extends ThemedTextureButton
@onready var level_name: LineEdit = $"../LevelName"

func _on_pressed() -> void:
	var Config = ConfigFile.new()
	var err = Config.load("user://SavedLevels.cfg")
	print("err: ", err)
	Config.erase_section(level_name.text)
	Config.save("user://SavedLevels.cfg")
	Load.LoadScene("res://Scenes/editor_levels.tscn")
	
