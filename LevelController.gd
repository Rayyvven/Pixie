extends Node
var TotalTiles = 0
@onready var file_dialog: FileDialog = $"../SongFile/FileDialog"
@onready var export_dir: FileDialog = $ExportDir

var LevelData = {
	"Level Info": {
	"Name": "Unnamed",
	"Description": "N/A",
	"Author": "Dev",
	"Song": "res://Music/Alone With Me - Good Kid.mp3",
	"Artist": "N/A",
	"SongFile": "N/A",
	"Difficulty": "Easy",
	"Dust": 1.0,
	"Speed": 1,
	"Length": 0
},
	"Level Data": {
	"Tile1":
	[1, 1, 180, -1080],
}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func save(dir):
	#var base_dir = "user://Levels/"
	var base_dir = dir+"/"
	DirAccess.make_dir_recursive_absolute(base_dir)

	var level_name = LevelController.LevelData["Level Info"]["Name"]
	var LVLDIR = base_dir + level_name
	DirAccess.make_dir_recursive_absolute(LVLDIR)

	var SongCopy = file_dialog.get_current_path()
	var file_name = SongCopy.get_file()
	var dest_path = LVLDIR + "/" + file_name

	# Copy file safely
	var data = FileAccess.get_file_as_bytes(SongCopy)
	var file = FileAccess.open(dest_path, FileAccess.WRITE)
	if file:
		file.store_buffer(data)
		file.close()

	# Save JSON
	var path = LVLDIR + "/LevelData.json"
	var JSON_string = JSON.stringify(LevelController.LevelData, "\t")
	var json_file = FileAccess.open(path, FileAccess.WRITE)
	if json_file:
		json_file.store_string(JSON_string)
		json_file.close()

	print("Saved successfully to ", LVLDIR)



func _on_export_dir_dir_selected(dir: String) -> void:
	var base_dir = dir+"/"
	save(dir)


func _on_pressed() -> void:
	export_dir.visible = true
	await export_dir.file_selected
