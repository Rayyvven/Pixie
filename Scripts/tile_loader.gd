extends Node
@onready var tile_placer: Node2D = $"../TilePlacer"
@onready var tile_placer_slider: Node2D = $"../TilePlacerSlider"
@onready var tile_placer_flick: Node2D = $"../TilePlacerFlick"
@onready var v_scroll_bar: VScrollBar = %VScrollBar


var i = 1
func _ready() -> void:

	push_warning("Loading", LevelController.LevelData)
	while "Tile" + str(i) in LevelController.LevelData["Level Data"]:
		v_scroll_bar.max_value = LevelController.LevelData["Level Info"]["Length"]
		v_scroll_bar.value = v_scroll_bar.max_value
		if LevelController.LevelData["Level Data"]["Tile" + str(i)] != ["Null"]:
			var B = tile_placer.duplicate()
			if LevelController.LevelData["Level Data"]["Tile" + str(i)] [0] == 1:
				B = tile_placer.duplicate()
			elif LevelController.LevelData["Level Data"]["Tile" + str(i)] [0] == 2:
				B = tile_placer_slider.duplicate()
				B.get_child(2).scale.y = LevelController.LevelData["Level Data"]["Tile" + str(i)] [1]
				print(B.get_child(4).name)
				B.get_child(4).value = LevelController.LevelData["Level Data"]["Tile" + str(i)] [1]
				print("Scale: ", LevelController.LevelData["Level Data"]["Tile" + str(i)] [1])
			elif LevelController.LevelData["Level Data"]["Tile" + str(i)] [0] == 3:
				B = tile_placer_flick.duplicate()
				B.get_child(1).rotation = LevelController.LevelData["Level Data"]["Tile" + str(i)] [1]
				B.get_child(2).value = LevelController.LevelData["Level Data"]["Tile" + str(i)] [1]
			B.position.x = LevelController.LevelData["Level Data"]["Tile" + str(i)][2]
			B.position.y = LevelController.LevelData["Level Data"]["Tile" + str(i)][3]
			add_child(B)
			print("Placed Tile ", i)
		i += 1
		print("Tiles Placed: ", i)
	LevelController.Loading = false
	print("Loaded Level!")
