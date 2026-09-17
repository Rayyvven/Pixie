extends LineEdit
@export var old_text: String
@export var ID: int
@onready var s: LineEdit = $"."

func _ready() -> void:
	s.old_text = text
	print("Old Text:", old_text)
	print("ID: ", s.ID)

func _on_text_changed(new_text: String) -> void:

	print(new_text)
	var Config = ConfigFile.new()
	var err = Config.load("user://SavedLevels.cfg")
	if err != OK:
		return
	var Sections = Config.get_sections()
	var NM = Config.get_value(Sections[Sections.rfind(str(s.old_text), -1)], "Level")
	NM["Level Info"]["Name"] = new_text
	Config.erase_section(s.old_text)
	Config.set_value(new_text, "Level", NM)
	#Config.set_value(str(s.ID), s.old_text, new_text)
	s.old_text = text
	Config.save("user://SavedLevels.cfg")
	
