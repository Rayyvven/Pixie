extends Node2D
@onready var camera_2d: Camera2D = $"../UI Elements/Camera2D"
@onready var tile: TextureButton = $TextureButton
@onready var options_menu: Node2D = %OptionsMenu

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
	#data["Level Data"]("Tile")
	LevelController.TotalTiles += 1
	TileID = "Tile" + str(LevelController.TotalTiles)
	print(LevelController.TotalTiles)
	LevelController.LevelData["Level Data"]["Tile" + str(LevelController.TotalTiles)] = [1, 1, position.x, position.y]
	print(LevelController.LevelData)
	print("Saved?")
	

	return TileID
	#var file = FileAccess.open(path, FileAccess.WRITE)
	#file.store_string(json.stringify(data))
	#file.close()
	#file = null
	

var dragging = false
var offset = Vector2(0,0)
func _process(delta: float) -> void:
	if dragging == true:
		position = get_global_mouse_position() - offset
	if get_global_mouse_position().x >= 1000 == true:
		tile.disabled = true
		#print("Disabled Tile")
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
		queue_free()
	else:
		if get_global_mouse_position().x < 357:
			position.x = 180
		elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
			position.x = 540
		else:
			position.x = 900
		position.y = snapped(position.y, 100)
		#print("Placed at ", position)
		print_rich("[color=cyan]Placed Tile at [/color]", position)

		LevelController.LevelData["Level Data"][TileID] = [1, 1, position.x, position.y]
		print("Modified: ", LevelController.LevelData)
func _on_texture_button_button_down() -> void:
	offset = get_global_mouse_position() - global_position
	dragging = true
	
	print("dragging...", global_position)
