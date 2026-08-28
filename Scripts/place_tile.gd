extends Node2D
@onready var editor: Node2D = $".."

@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var row_control: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/RowControl"
@onready var file_dialog: FileDialog = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/SongFileDialog"
@onready var music: AudioStreamPlayer = $"../Music"
@onready var background_video: VideoStreamPlayer = $"../BackgroundControl/BackgroundVideo"
@onready var video_dialog: FileDialog = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/Video/VideoDialog"
@onready var video_button: Button = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/Video"
@onready var song_button: Button = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile"


@onready var tile_placer_slider: Node2D = $"../TilePlacerSlider"
@onready var tile_placer_flick: Node2D = $"../TilePlacerFlick"
@onready var tile_placer: Node2D = $"../TilePlacer"
@onready var song_file_label: Label = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/Song File Label"
@onready var song_artist: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 4/SongArtist"
@onready var speed_val: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var level_name: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/LevelName"
@onready var level_description: TextEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/LevelDescriptionLabel"
@onready var song_file: Button = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile"
@onready var id_label: Label = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/LevelName/IDLabel"
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var tile_layer: CanvasLayer = $"../TileLayer"



@export var TotalTiles : int = 0
signal LoadFromTrackController
var drag_screen = false
var location = get_global_mouse_position().y
var Options = ConfigFile.new()
var err = Options.load("user://options.cfg")
### ROW CONTROL
## 0 - 1080
## One Row: 1080/(Rows+1) * Rows
## Two Rows: 1080/3 (Row 1) 1080/3*2 (Row 2)
## Three Rows: 1080/4 (Row 1) 1080/4*2 (Row 2) 1080/4*3 (Row 3)
## Snapped(1080/Row+1)

func _ready() -> void:
	print("hi")
	LevelController.Loading = true
	print("Loading:", LevelController.Loading)
	id_label.text = str(LevelController.LevelData["Level Info"]["ID"])
	if LevelController.LevelData["Level Info"]["ID"] != -1:
		LoadFromTrackController.emit()

func _process(delta: float) -> void:
	if drag_screen == true:
		v_scroll_bar.value -= ((int(get_global_mouse_position().y) - int(location)) * 4) * delta

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			location = get_global_mouse_position().y
			drag_screen = true
	if event is InputEventMouseButton and event.is_released():
		if not (get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true or get_viewport().get_mouse_position().y >= 1500 or get_viewport().get_mouse_position().y <= 150 and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown):
			if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
				drag_screen = false
				if not location <= get_global_mouse_position().y - 10 and not location >= get_global_mouse_position().y + 10:
					if LevelController.TotalTiles != len(LevelController.LevelData["Level Data"]): ### Double-checks.
						LevelController.TotalTiles = len(LevelController.LevelData["Level Data"])
					
					#LevelController.TotalTiles += 1
					var t = tile_placer.duplicate() ## Simply creates the variable
					t.TileID = LevelController.TotalTiles
					if SelectedTile.TileSelect == 1:
						t = tile_placer.duplicate()
					elif SelectedTile.TileSelect == 2:
						t = tile_placer_slider.duplicate()
					elif SelectedTile.TileSelect == 3:
						t = tile_placer_flick.duplicate()
					t.position = get_global_mouse_position()
					if Options.get_value("Editor", "UpdatedRowCalculation") == true:
						t.position.x = snapped(t.position.x, 1080/(int(row_control.text)+1))
						print("Row Val: ", 1080/int(row_control.text))
						t.scale.x = 3/float(row_control.text)
						t.scale.y = 3/float(row_control.text)
					else:
						if get_global_mouse_position().x < 357:
							t.position.x = 180
						elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
							t.position.x = 540
						else:
							t.position.x = 900
					if TileSnap.SnapY == true:
						t.position.y = snapped(get_global_mouse_position().y, 100)
					print("Mouse pos:", get_global_mouse_position())
					if SelectedTile.TileSelect == 2: 
						t.position.y += 90
					t.visible = true
					LevelController.TotalTiles += 1
					add_child(t)
					print("Placed Tile at ", t.position)
					Input.vibrate_handheld(100, 0.075)## For Mobile: vibrates the phone a little.

func _on_import_load_level(dir: String):
	LevelController.TotalTiles = 1
	@warning_ignore("unused_variable")
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
	LevelController.LevelData = LevelController.DefaultLevelData

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
	music.stream = stream
	var current_stream_name = music.stream.resource_name
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
				T.rotation_degrees = JSONDict["Level Data"]["Tile" + str(i)] [4]
				T.get_child(4).value = JSONDict["Level Data"]["Tile" + str(i)] [1]
			elif JSONDict["Level Data"]["Tile" + str(i)] [0] == 3:
				T = tile_placer_flick.duplicate()
				T.get_child(1).rotation = JSONDict["Level Data"]["Tile" + str(i)] [1]
				T.get_child(2).value = JSONDict["Level Data"]["Tile" + str(i)] [1]
			T.position.x = JSONDict["Level Data"]["Tile" + str(i)][2]
			T.position.y = JSONDict["Level Data"]["Tile" + str(i)][3]
			T.visible = true
			canvas_layer.add_child(T)
			print("Placed Tile ", i)
		i += 1

func _on_load_from_track_controller():
	LevelController.TotalTiles = 1
	LevelController.SavedLevelData = LevelController.LevelData
	print("Saved Data:", LevelController.SavedLevelData)
	LevelController.LevelData = LevelController.DefaultLevelData
	push_warning("Reset Level Data!")
	level_name.text = LevelController.SavedLevelData["Level Info"]["Name"]
	level_description.text = LevelController.SavedLevelData["Level Info"]["Description"]
	song_artist.text = LevelController.SavedLevelData["Level Info"]["Artist"]
	speed_val.text = str(LevelController.SavedLevelData["Level Info"]["Speed"])
	print(LevelController.SavedLevelData["Level Info"]["SongFile"])
	
	## Music Loader
	DirAccess.make_dir_absolute("user://music")
	var file = FileAccess.open("user://music/" + LevelController.SavedLevelData["Level Info"]["SongFile"], FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	music.stream = sound
	file_dialog.set_current_path("user://music/" + LevelController.SavedLevelData["Level Info"]["SongFile"])
	print("FileDialog: ", file_dialog.get_current_path())

	song_button.text = "Song File: \n" + LevelController.SavedLevelData["Level Info"]["SongFile"]
	
	## Video Loader
	DirAccess.make_dir_absolute("user://video")
	var VideoFile = FileAccess.open("user://video/" + LevelController.SavedLevelData["Level Info"]["VideoFile"], FileAccess.READ)
	var Video = VideoStreamPlayer.new()
	#Video.data = VideoFile.get_buffer(VideoFile.get_length())
	#Video.stream = load(VideoFile)
	background_video.set_stream(load("user://video/" + LevelController.SavedLevelData["Level Info"]["VideoFile"]))
	video_dialog.set_current_path("user://video/" + LevelController.SavedLevelData["Level Info"]["VideoFile"])
	print("VideoDialog: ", video_dialog.get_current_path())
	video_button.text = "Video File: \n" + LevelController.SavedLevelData["Level Info"]["VideoFile"]
	
	var i = 1
	while "Tile"+str(i) in LevelController.SavedLevelData["Level Data"]:
		if "Tile"+str(i) not in LevelController.SavedLevelData["Level Data"]:
			pass
		elif LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] != ["Null"]:
			var B = tile_placer.duplicate()
			if LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [0] == 1:
				B = tile_placer.duplicate()
			elif LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [0] == 2:
				B = tile_placer_slider.duplicate()
				B.get_child(2).scale.y = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [1]
				print(B.get_child(4).name)
				B.rotation_degrees = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [4]
				B.get_child(4).value = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [1]
				B.get_child(5).value = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [4]
			elif LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [0] == 3:
				B = tile_placer_flick.duplicate()
				B.get_child(1).rotation = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [1]
				B.get_child(2).value = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)] [1]
			B.position.x = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)][2]
			B.position.y = LevelController.SavedLevelData["Level Data"]["Tile" + str(i)][3]
			B.visible = true
			
			LevelController.TotalTiles += 1
			canvas_layer.add_child(B)
			print("Placed Tile ", i)
		else:
			print("Skipping Null Tile")
			LevelController.TotalTiles += 1 ## Control
		i += 1
		print("it: ", i)
		await get_tree().create_timer(0.01).timeout
	LevelController.Loading = false
	LevelController.LevelData = LevelController.SavedLevelData
	print("Level Data: ", LevelController.LevelData)
	print("Loaded Level!")
