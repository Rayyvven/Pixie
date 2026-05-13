extends Node2D
@onready var camera_2d: Camera2D = $"../UI Elements/Camera2D"
@onready var tileold: TextureButton = $SlideTile
@onready var tile: Button = $SlideTileBase
@onready var options_menu: Node2D = %OptionsMenu
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var place_tile = get_node("Place Tile")
@onready var scale_control: VSlider = $ScaleControl


signal place
signal delete
var json = JSON.new()
var path = "user://level.json"
var data = {
	"Level Info": {
	"Name": "Level",
	"Artist": "Artist",
	"Author": "Author",
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
var TileID = ""
func save_level():
	#data["Level Data"]("Tile")
	LevelController.TotalTiles += 1
	TileID = "Tile" + str(LevelController.TotalTiles)
	if TileID == "Tile3" or TileID == "Tile2" or TileID == "Tile1":
		position.x -= 2500
	print(LevelController.TotalTiles)
	if scale_control:
		LevelController.LevelData["Level Data"]["Tile" + str(LevelController.TotalTiles)] = [2, scale_control.value, position.x, position.y]
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
		if SmoothDrag.DragSmooth == false:
			print("GridSnapDrag")
			if TileSnapX.SnapX == true:
				if get_global_mouse_position().x < 357:
					position.x = 180
				elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
					position.x = 540
				else:
					position.x = 900
			if TileSnap.SnapY == true:
				position.y = snapped(position.y, 100)
	if get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true or get_viewport().get_mouse_position().y >= 1700 or get_viewport().get_mouse_position().y <= 150 and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown:
		tile.disabled = true
		#print("Disabled Tile")
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
		if TileSnapX.SnapX == true:
			if get_global_mouse_position().x < 357:
				position.x = 180
			elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
				position.x = 540
			else:
				position.x = 900
		if TileSnap.SnapY == true:
			position.y = snapped(position.y, 100)
		print_rich("[color=cyan]Placed Tile at [/color]", position)
		place.emit()
		if scale_control:
			LevelController.LevelData["Level Data"][TileID] = [2, scale_control.value, position.x, position.y]
		else:
			push_warning("Error: Scale Control does not exist!")
		print("Modified: ", LevelController.LevelData)

func _on_scale_control_changed() -> void:
		LevelController.LevelData["Level Data"][TileID] = [2, scale_control.value, position.x, position.y]
		print("Modified: ", LevelController.LevelData)
