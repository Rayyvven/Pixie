extends Node2D

@onready var place_tile = get_node("Place Tile")
@onready var tile: TextureButton = $BasicTile
@onready var options_menu: Control = %OptionsMenu
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var tile_id_label: Label = $TileIDLabel
@onready var camera_2d: Camera2D = $"../CanvasLayer/Camera2D"
@onready var row_control: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/RowControl"
var Options = ConfigFile.new()
var err = Options.load("user://options.cfg")

var TileID = ""
signal place
signal delete
var dragging = false
var offset = Vector2(0,0)
var json = JSON.new()
var path = "user://level.json"
var data = LevelController.DefaultLevelData

func save_level():
	if visible:
		TileID = "Tile" + str(LevelController.TotalTiles-1)
		tile_id_label.text = TileID
		print(LevelController.TotalTiles)
		LevelController.LevelData["Level Data"][TileID] = [1, 1, position.x, position.y]
		print(LevelController.LevelData)
		print("Saved?")
		print("TileID: ", TileID, "LevelController: ", LevelController.TotalTiles)
		#LevelController.TotalTiles += 1
		return TileID

func _process(delta: float) -> void:
	if Options.get_value("Editor", "ShowTileIDs") == true:
		tile_id_label.visible = true
	else:
		tile_id_label.visible = false
	
	if dragging == true:
		position = get_global_mouse_position() - offset
		if SmoothDrag.DragSmooth == false:
			print("GridSnapDrag")
			if Options.get_value("Editor", "SnapX") == true:
				position.x = snapped(position.x, 1080/(int(LevelController.LevelData["Level Info"]["Rows"])+1))
			if Options.get_value("Editor", "SnapY") == true:
				position.y = snapped(position.y, 100)
	if get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true or get_viewport().get_mouse_position().y >= 1500 or get_viewport().get_mouse_position().y <= 150 and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown:
		tile.disabled = true
		tile.mouse_filter = Control.MOUSE_FILTER_IGNORE
		modulate.a = .5
	else:
		tile.disabled = false
		tile.mouse_filter = Control.MOUSE_FILTER_STOP
		modulate.a = 1

func _ready() -> void:
	data = save_level()
	print(data)

func _on_texture_button_button_up() -> void:
	dragging = false
	if get_global_mouse_position().x <= 30 or get_global_mouse_position().x >= 960:
		LevelController.LevelData["Level Data"][TileID] = ["Null"]
		print_rich("[color=yellow]Removed Tile! [/color]")
		print(LevelController.LevelData)
		delete.emit()
		queue_free()
	else:
		if Options.get_value("Editor", "SnapX") == true:
			if Options.get_value("Editor", "UpdatedRowCalculation") == true:
				position.x = snapped(position.x, 1080/(int(LevelController.LevelData["Level Info"]["Rows"])+1))
			else:
				if get_global_mouse_position().x < 357:
					position.x = 180
				elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
					position.x = 540
				else:
					position.x = 900
		if Options.get_value("Editor", "SnapY") == true:
			position.y = snapped(position.y, 100)
		if LevelController.SnapTilesToBPM == true:
			var snap = float(LevelController.LevelData["Level Info"]["Speed"]) / (float(LevelController.BPM) / 60.0)
			var origin = float(LevelController.LevelData["Level Info"]["Length"]) * float(LevelController.LevelData["Level Info"]["Speed"])
			position.y = snapped(position.y - origin, snap) + origin
			#position.y = snapped(position.y, float(LevelController.LevelData["Level Info"]["Speed"]) / (float(LevelController.BPM)/60.0))
			print(float(LevelController.LevelData["Level Info"]["Speed"]) / (float(LevelController.BPM)/60.0))
			print(LevelController.BPM)
			print(LevelController.LevelData["Level Info"]["Speed"])
		print_rich("[color=cyan]Placed Tile at [/color]", position)
		place.emit()
		LevelController.LevelData["Level Data"][TileID] = [1, 1, position.x, position.y]
		print("Modified: ", LevelController.LevelData)

func _on_texture_button_button_down() -> void:
	offset = get_global_mouse_position() - global_position
	dragging = true
	print("dragging...", global_position)
