extends Node

var JSON_file = "res://Assets/Level.json"
var TileScene := preload("res://Scenes/Tile.tscn")  # <-- literal path

func load_JSON_file():
	assert(FileAccess.file_exists(JSON_file), "File Does Not Exist!")
	var file = FileAccess.open(JSON_file, FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	var json_data = JSON.parse_string(json_text)
	
	var Info = json_data["Level Info"]["Name"]
	print(Info)

	var c = 0
	while true:
		c += 1
		var Thing = "Tile" + str(c)
		if Thing not in json_data["Level Data"]:
			print("Level loaded!")
			break
		else:
			var T = json_data["Level Data"][Thing]
			var P = TileScene.instantiate()
			P.position = Vector2(T[2], T[3])
			
			add_child(P)
			print("Added Tile at " + str(T[2]) + "," + str(T[3]))

func _ready():
	load_JSON_file()
