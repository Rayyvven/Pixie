extends Node2D
@onready var tile_placer_slider: Node2D = $"../TilePlacerSlider"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../UI Elements/Camera2D/AudioStreamPlayer2D"
@onready var tile_placer_flick: Node2D = $"../TilePlacerFlick"
@onready var song_file_label: Label = $"../UI Elements/Camera2D/Options/OptionsMenu/SongFile/Song File Label"
@onready var song_artist: LineEdit = $"../UI Elements/Camera2D/Options/OptionsMenu/SongArtist"
@onready var speed_val: LineEdit = $"../UI Elements/Camera2D/Options/OptionsMenu/SpeedVal"
@onready var test_tile: Node2D = $"../TestTile"
@onready var tile_placer: Node2D = $"../TilePlacer"
@export var TotalTiles : int = 0
@onready var level_name: LineEdit = $"../UI Elements/Camera2D/Options/OptionsMenu/LevelName"
@onready var level_description: LineEdit = $"../UI Elements/Camera2D/Options/OptionsMenu/LevelDescription"
@onready var song_file: Button = $"../UI Elements/Camera2D/Options/OptionsMenu/SongFile"
func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if not get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true or get_viewport().get_mouse_position().y >= 1700 or get_viewport().get_mouse_position().y <= 150 and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown:
			if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
				var t = tile_placer.duplicate() ## Simply creates the variable
				if SelectedTile.TileSelect == 1:
					t = tile_placer.duplicate()
				elif SelectedTile.TileSelect == 2:
					t = tile_placer_slider.duplicate()
				elif SelectedTile.TileSelect == 3:
					t = tile_placer_flick.duplicate()
				t.position = get_global_mouse_position()
				if get_global_mouse_position().x < 357:
					t.position.x = 180
				elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
					t.position.x = 540
				else:
					t.position.x = 900
				if TileSnap.SnapY == true:
					t.position.y = snapped(get_global_mouse_position().y, 100)
				print("Mouse pos:", get_global_mouse_position())
				add_child(t)
				print("Placed Tile at ", t.position)
				
				Input.vibrate_handheld(100, 0.025) ## For Mobile: vibrates the phone a little. For some strange reason, it doesn't work.


func _on_import_load_level(dir: String) -> void:
	var json = JSON.new()
	var path = dir + "//LevelData.json"

	var file = FileAccess.open(path, FileAccess.READ)
	
	if file == null:
		print("Failed to open file")
		return
	
	var content = file.get_as_text()
	file.close()
	var JSONDict = JSON.parse_string(content)
	print(path)
	LevelController.LevelData = {
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

	print("Reset Level Data!")
	LevelController.LevelData["Level Info"]["Name"] = JSONDict["Level Info"]["Name"]
	level_name.text = JSONDict["Level Info"]["Name"]
	LevelController.LevelData["Level Info"]["Description"] = JSONDict["Level Info"]["Description"]
	level_description.text = JSONDict["Level Info"]["Description"]
	LevelController.LevelData["Level Info"]["Author"] = JSONDict["Level Info"]["Author"]
	LevelController.LevelData["Level Info"]["Song"] = JSONDict["Level Info"]["Song"]
	LevelController.LevelData["Level Info"]["SongFile"] = JSONDict["Level Info"]["SongFile"]
	LevelController.LevelData["Level Info"]["Artist"] = JSONDict["Level Info"]["Artist"]
	song_artist.text = LevelController.LevelData["Level Info"]["Artist"]
	LevelController.LevelData["Level Info"]["Speed"] = JSONDict["Level Info"]["Speed"]
	speed_val.text = str(LevelController.LevelData["Level Info"]["Speed"])
	print(LevelController.LevelData["Level Info"]["Song"])
	var stream = AudioStreamMP3.new()
	var songfile = FileAccess.open(JSONDict["Level Info"]["Song"], FileAccess.READ) ## This is stupid
	stream.data = songfile.get_buffer(songfile.get_length())
	audio_stream_player_2d.stream = stream
	var current_stream_name = audio_stream_player_2d.stream.resource_name
	song_file_label.text = "Song File: \n" + LevelController.LevelData["Level Info"]["SongFile"]
	print("Loaded song file ", current_stream_name)
	var i = 1
	while "Tile" + str(i) in JSONDict["Level Data"]:
		if JSONDict["Level Data"]["Tile" + str(i)] != ["Null"]:
			var T = tile_placer.duplicate()
			if JSONDict["Level Data"]["Tile" + str(i)] [0] == 1:
				T = tile_placer.duplicate()
			elif JSONDict["Level Data"]["Tile" + str(i)] [0] == 2:
				T = tile_placer_slider.duplicate()
				T.get_child(2).scale.y = JSONDict["Level Data"]["Tile" + str(i)] [1]
				print(T.get_child(4).name)
				T.get_child(4).value = JSONDict["Level Data"]["Tile" + str(i)] [1]
			elif JSONDict["Level Data"]["Tile" + str(i)] [0] == 3:
				T = tile_placer_flick.duplicate()
				T.get_child(1).rotation = JSONDict["Level Data"]["Tile" + str(i)] [1]
				T.get_child(2).value = JSONDict["Level Data"]["Tile" + str(i)] [1]
			T.position.x = JSONDict["Level Data"]["Tile" + str(i)][2]
			T.position.y = JSONDict["Level Data"]["Tile" + str(i)][3]
			add_child(T)
			print("Placed Tile ", i)
		i += 1
