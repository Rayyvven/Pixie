extends Button
@onready var camera_2d: Camera2D = $"../UI Elements/Camera2D"
@onready var tile: TextureButton = $SlideTile
@onready var options_menu: Node2D = %OptionsMenu
@onready var v_scroll_bar: VScrollBar = %VScrollBar
signal place
signal delete
#@onready var place_tile: Node2D = %"Place Tile"
@onready var place_tile = get_node("Place Tile")

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
	LevelController.TotalTiles += 1
	TileID = "Tile" + str(LevelController.TotalTiles)
	print(LevelController.TotalTiles)
	LevelController.LevelData["Level Data"]["Tile" + str(LevelController.TotalTiles)] = [2, 1, position.x, position.y]
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
			if get_global_mouse_position().x < 357:
				position.x = 180
			elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
				position.x = 540
			else:
				position.x = 900
			if TileSnap.SnapY == true:
				position.y = snapped(position.y, 100)
	if get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true or get_viewport().get_mouse_position().y >= 1700 or get_viewport().get_mouse_position().y <= 150 and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown:
		disabled = true
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		modulate.a = .5
	else:
		disabled = false
		mouse_filter = Control.MOUSE_FILTER_STOP
		modulate.a = 1

func _ready() -> void:
	data = save_level()
	print(data)

func _on_button_down() -> void:
	offset = get_global_mouse_position() - global_position
	dragging = true
	print("dragging...", global_position)


func _on_button_up() -> void:
	dragging = false
	if get_global_mouse_position().x <= 30 or get_global_mouse_position().x >= 960:
		LevelController.LevelData["Level Data"][TileID] = ["Null"]
		print_rich("[color=yellow]Removed Tile! [/color]")
		print(LevelController.LevelData)
		delete.emit()
		queue_free()
	else:
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

		LevelController.LevelData["Level Data"][TileID] = [1, 1, position.x, position.y]
		print("Modified: ", LevelController.LevelData)
