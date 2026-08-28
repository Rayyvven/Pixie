extends Control
@onready var VC: VBoxContainer = $CanvasLayer/Panel/ScrollContainer/VBoxContainer
@onready var level_det_container: HBoxContainer = $CanvasLayer/Panel/ScrollContainer/VBoxContainer/TestContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MusicFolder = "user://music"
	DirAccess.make_dir_absolute(MusicFolder)
	print("Created Folder: MusicFolder 'user://music'")
	var Config = ConfigFile.new()
	
	var err = Config.load("user://SavedLevels.cfg")
	print("err: ", err)
	var i = 0
	for section in Config.get_sections():
		var Dupe = level_det_container.duplicate()
		
		var NM = Config.get_value(str(i), "Level")
		
		if "Version" not in NM["Level Info"] or NM["Level Info"]["Version"] != "0.1.1b":
			Dupe.get_child(0).modulate = Color(1.0, 0.84, 0.877, 0.478)
		
		Dupe.get_child(0).text = NM["Level Info"]["Name"]
		Dupe.get_child(0).ID = i
		Dupe.get_child(1).ID = i ## Such that you can edit tracks I think
		Dupe.visible = true
		VC.add_child(Dupe)
		VC.move_child(Dupe, 0)
		print("Added Child: ", section)
		i += 1
	
	
	
	#var SavedLevels = FileAccess.open("res://SavedLevels.json", FileAccess.READ)
	#var Content = JSON.parse_string(SavedLevels.get_as_text())
	#for i in Content:
		#var Dupe = level_det_container.duplicate()
		#Dupe.get_child(0).text = Content[str(i)]["Level Info"]["Name"]
		#Dupe.visible = true
		#VC.add_child(Dupe)
		#print("Added Child", Content[str(i)]["Level Info"]["Name"])
