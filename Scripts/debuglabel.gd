extends Label

@onready var play: TextureButton = $"../Yikes/Play"
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var speed_val: LineEdit = $"../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var level_name: LineEdit = $"../OptionsMenu/OptionsPanel/MainVerticalContainer/LevelName"
@onready var file_dialog: FileDialog = $"../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/SongFileDialog"
@onready var tile_placer: Node2D = $"../../TilePlacer"
@onready var selected_tile: Node = $"../TileSelect/SelectedTile"
@onready var play_position: Button = $"../../PlayPosition"
@onready var length_label: Label = $"../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/Length Label"
@onready var debug_check: CheckButton = $"../OptionsMenu/OptionsPanel/DebugCheck"
@onready var background: ColorRect = $"../../BackgroundControl/Background"

func _process(delta: float) -> void:
	if debug_check.button_pressed:
		text = "Speed: " + str(play.Speed) + "\nPosition: " + str(position.y) + "\n" + "PlayPos: " + str(play_position.position.y) + "\nScroll: " + str(%VScrollBar.value) + "\nSeek: " + str(play.startfrom) + "\nSeekReal: " +  str(play_position.startfrom) + "\nSpeedStat: " + str(speed_val.speed) + "\nMouse: " + str(get_global_mouse_position()) + "\nLevel Name: " + str(level_name.text) + "\nSong: " + str(file_dialog.get_current_file()) + "\nFPS: " + str(Engine.get_frames_per_second()) + "\nTiles Placed: " + str(LevelController.TotalTiles) + "\nSubmitted Level Name: " + str(LevelController.LevelData["Level Info"]["Name"]) + "\nSubmitted Description: " + str(LevelController.LevelData["Level Info"]["Description"]) + "\nSubmitted Song Name: " + str(LevelController.LevelData["Level Info"]["Song"]) + "\nSubmitted Speed: " + str(LevelController.LevelData["Level Info"]["Speed"]) + "\nDf: " + str(LevelController.LevelData["Level Info"]["Difficulty"]) + "\nBackground Color: " + str(background.color) + "\nTileSnap? " + str(TileSnap.SnapY) + "\nRelativeMousePos: " + str(get_viewport().get_mouse_position()) + "\nSelectedTile: " + str(SelectedTile.TileSelect) + "\nMax Track Length: " + str(v_scroll_bar.max_value) + "\nSong Length: " + str(length_label.text) + "\nCurrent Speed: " + str(speed_val.text) + "\nDelta: " + str(delta) + "\nSnapToBPM: " + str(LevelController.SnapTilesToBPM)
	else:
		text = ""
