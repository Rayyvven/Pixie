extends TextureButton
class_name Tile
### This is the class for the editor tiles. This will be used
### as the base for all future tiles and existing tiles.
### This will serve as a means to condense the tile creation process
### for the future.

@export_category("Tile Properties")
@export var TileID: String ## In editor name to refer to the tile
@export var TileName: String ## Human readable name for the tile
@export var TileLayer: Node2D ## Should be the $TileLayer node
@export_category("Advanced Tile Properties")
@export var Modded: bool ## Used in exclusively modded tiles.
@export var UsesCustomProperties: bool ## Enable custom vars
@export var CustomProperties: Dictionary ## Custom vars, such as
## the speed on SpeedTiles.

### The vast majority of this code is lifted from the old
### tile code. This will hopefully allow for easier tile additions
### & less hundred+ line scripts. This will also hopefully allow for easier
### debugging. This was all added via the 0.1.2 update.


var Options = ConfigFile.new()
var err = Options.load("user://options.cfg")
var TileNum
signal place
signal delete
var dragging = false
var offset = Vector2(0,0)
var json = JSON.new()
var path = "user://level.json"
var data = LevelController.DefaultLevelData

func save_level():
	if visible:
		TileNum = "Tile" + str(LevelController.TotalTiles-1)
		print(LevelController.TotalTiles)
		LevelController.LevelData["Level Data"][TileNum] = [self.TileID, 1, position.x, position.y]
		print("Save attempt")
		print("TileNum: ", TileNum, "LevelController: ", LevelController.TotalTiles)
		#LevelController.TotalTiles += 1
		return TileNum

func _process(delta: float) -> void:	
	if dragging == true:
		position = get_global_mouse_position() - offset
		if SmoothDrag.DragSmooth == false:
			print("GridSnapDrag")
			if Options.get_value("Editor", "SnapX"):
				position.x = snapped(position.x, 1080/(int(LevelController.LevelData["Level Info"]["Rows"])+1))
			if Options.get_value("Editor", "SnapY") == true:
				position.y = snapped(position.y, 100)
	if get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown:
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
		print_rich("[color=cyan]Placed Tile at [/color]", position)
		place.emit()
		LevelController.LevelData["Level Data"][TileID] = [1, 1, position.x, position.y]
		print("Modified: ", LevelController.LevelData)

func _on_texture_button_button_down() -> void:
	offset = get_global_mouse_position() - global_position
	dragging = true
	print("dragging...", global_position)
