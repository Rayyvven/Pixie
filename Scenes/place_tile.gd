extends Node2D

var editor_tile := preload("res://Scenes/editortile.tscn")
@onready var test_tile: Node2D = $"../TestTile"
@onready var tile_placer: Node2D = $"../TilePlacer"
@export var TotalTiles : int = 0

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			var t = tile_placer.duplicate()
			t.position = get_global_mouse_position()
			if get_global_mouse_position().x < 357:
				t.position.x = 180
			elif get_global_mouse_position().x > 357 and get_global_mouse_position().x < 720:
				t.position.x = 540
			else:
				t.position.x = 900
			t.position.y = snapped(get_global_mouse_position().y, 100)
			print("Mouse pos:", get_global_mouse_position())
			add_child(t)
			print("Placed Tile at ", t.position)
