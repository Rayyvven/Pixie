extends Node2D

@onready var options_menu: Control = %OptionsMenu
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var place_tile = get_node("Place Tile")
@onready var scale_control: VSlider = $ScaleControl
@onready var tile: Button = $SlideTileBase
@onready var camera_2d: Camera2D = $"../CanvasLayer/Camera2D"
signal place
signal delete
var json = JSON.new()
var path = "user://level.json"
var data = LevelController.DefaultLevelData
var TileID = ""
var Options = ConfigFile.new()
var err = Options.load("user://options.cfg")
func save_level():
	if visible:
		#LevelController.TotalTiles += 1
		TileID = "Tile" + str(LevelController.TotalTiles-1)
		#if TileID == "Tile3" or TileID == "Tile2" or TileID == "Tile1":
			#position.x -= 2500
		print(LevelController.TotalTiles)
		if scale_control:
			LevelController.LevelData["Level Data"]["Tile" + str(LevelController.TotalTiles)] = [2, scale_control.value, position.x, position.y, rotation_degrees]
		else:
			push_warning("Error: Scale Control does not exist!")
		print(LevelController.LevelData)
		print("Saved?")
		return TileID

var dragging = false
var offset = Vector2(0,0)
func _process(delta: float) -> void:
	if dragging == true:
		position = get_global_mouse_position() - offset
		if Options.get_value("Editor", "SmoothDrag") == false:
			print("GridSnapDrag")
			if Options.get_value("Editor", "SnapX") == true:
				if get_global_mouse_position().x < 357:
					position.x = 180
				elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
					position.x = 540
				else:
					position.x = 900
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

func _ready():
	await get_tree().process_frame
	data = save_level()
	print(data)

func _on_slide_tile_base_button_down() -> void:
	offset = get_global_mouse_position() - global_position
	dragging = true
	print("dragging...", global_position)

func _on_slide_tile_base_button_up() -> void:
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
		print_rich("[color=cyan]Placed Tile at [/color]", position)
		place.emit()
		if scale_control:
			LevelController.LevelData["Level Data"][TileID] = [2, scale_control.value, position.x, position.y, rotation_degrees]
		else:
			push_warning("Error: Scale Control does not exist!")
		print("Modified: ", LevelController.LevelData)

func _on_scale_control_value_changed(value: float) -> void:
	LevelController.LevelData["Level Data"][TileID] = [2, scale_control.value, position.x, position.y, rotation_degrees]
	print("Modified: ", LevelController.LevelData)

func _on_rotation_control_value_changed(value: float) -> void:
	rotation_degrees = value
	LevelController.LevelData["Level Data"][TileID] = [2, scale_control.value, position.x, position.y, rotation_degrees]
	print("Modified: ", LevelController.LevelData)
