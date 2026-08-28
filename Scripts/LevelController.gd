extends Node

@onready var file_dialog: FileDialog = $"../../MainVerticalContainer/Row 3/SongFile/SongFileDialog"
@onready var export_dir: FileDialog = $ExportDir
@onready var export_progress: ProgressBar = $ExportingProg/ExportProgress
@onready var exporting_prog: ColorRect = $ExportingProg
@onready var debug: Label = $ExportingProg/ExportingDebug
@onready var exported_text: TextEdit = $ExportingProg/ExportedText
var TotalTiles = 0
var Loading = false
var SnapTilesToBPM = false
var BPM = 0
var SavedLevelData = {}

var LevelData = {
	"Level Info": {
	"ID": -1,
	"Name": "Unnamed",
	"Description": "N/A",
	"Author": "Dev",
	"Song": "res://Music/Alone With Me - Good Kid.mp3",
	"Artist": "N/A",
	"SongFile": "N/A",
	"VideoFile": "N/A",
	"BackgroundColor": Color(),
	"Difficulty": "Easy",
	"Dust": 1.0,
	"Speed": 500,
	"Length": 0,
	"Rows": 3,
	"Version": "0.1.1b"
},
	"Level Data": {

}
}

var DefaultLevelData = {
	"Level Info": {
	"ID": -1,
	"Name": "Unnamed",
	"Description": "N/A",
	"Author": "Dev",
	"Song": "res://Music/Alone With Me - Good Kid.mp3",
	"Artist": "N/A",
	"SongFile": "N/A",
	"VideoFile": "N/A",
	"BackgroundColor": Color(),
	"Difficulty": "Easy",
	"Dust": 1.0,
	"Speed": 500,
	"Length": 0,
	"Rows": 3,
	"Version": "0.1.1b"
},
	"Level Data": {

}
}

func _ready() -> void:
	LevelController.Loading = false
	LevelController.SnapTilesToBPM = false
	LevelController.BPM = 0

func save(dir):
	export_progress.value = 0
	exporting_prog.visible = true
	await get_tree().create_timer(.1).timeout ## Creates an artificial wait sequence so you know what's happening
	export_progress.value += 14 #1
	var base_dir = dir + "/"
	debug.text = "Exporting... \n Getting directory"
	print("Saving to: ", ProjectSettings.globalize_path(base_dir))
	DirAccess.make_dir_recursive_absolute(base_dir)
	export_progress.value += 14 #2
	var level_name = LevelController.LevelData["Level Info"]["Name"]
	var LVLDIR = base_dir + level_name
	DirAccess.make_dir_recursive_absolute(LVLDIR)
	debug.text = "Exporting... \n Creating file details"
	await get_tree().create_timer(.5).timeout
	export_progress.value += 14 #3
	# Copy Song
	
	var SongCopy = file_dialog.get_current_path()
	if SongCopy == "" or SongCopy == null or SongCopy == "C:/Users/Tobia/Godot/pixie/":
		print("Attempting to set song...")
		file_dialog.set_current_path("res://Assets/PixieAssets/1549510_Good-Kid---Alone-With-Me.mp3")
		await get_tree().create_timer(.2).timeout
		print("Set song to ", file_dialog.get_current_path())
	print("SongCopy: ", SongCopy)
	var file_name = SongCopy.get_file()
	var dest_path = LVLDIR + "/" + file_name
	export_progress.value += 14 #4
	debug.text = "Exporting... \n Copying song..." + str(file_name)
	await get_tree().create_timer(.5).timeout
	var source_file = FileAccess.open(SongCopy, FileAccess.READ)
	if source_file == null:
		print("Failed to read song!")
		print("Path: ", SongCopy)
		print("Error: ", FileAccess.get_open_error())
		return
	var data = source_file.get_buffer(source_file.get_length())
	source_file.close()
	var file = FileAccess.open(dest_path, FileAccess.WRITE)
	if file == null:
		print("Failed to write song!")
		print("Path: ", dest_path)
		print("Error: ", FileAccess.get_open_error())
		return
	file.store_buffer(data)
	file.close()
	export_progress.value += 14 #5
	# Save JSON
	
	var path = LVLDIR + "/LevelData.json"
	debug.text = "Exporting... \n Saving .JSON file to" + str(path)
	await get_tree().create_timer(1).timeout
	var JSON_string = JSON.stringify(LevelController.LevelData, "\t")
	var json_file = FileAccess.open(path, FileAccess.WRITE)
	export_progress.value += 14 #6
	if json_file:
		json_file.store_string(JSON_string)
		json_file.close()
	export_progress.value = 100 #7
	print("Saved successfully to ", LVLDIR)
	debug.text = "Success!"
	exporting_prog.visible = false



func _on_export_dir_dir_selected(dir: String) -> void:
	var base_dir = dir+"/"
	save(dir)

func _on_pressed() -> void:
	if exporting_prog.visible == false:
		exported_text.text = type_convert(LevelController.LevelData, TYPE_STRING)
		if OS.get_name() != "Android":
			export_dir.visible = true
			await export_dir.dir_selected
		else:
			exporting_prog.visible = true
			debug.text = "Since you are on Android, please follow the wiki for a guide on exporting."
			OS.shell_open("https://github.com/Rayyvven/Pixie/wiki/Exporting-on-Android")
	else:
		exporting_prog.visible = false
