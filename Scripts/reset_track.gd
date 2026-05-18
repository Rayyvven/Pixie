extends Button


func _on_pressed() -> void:
	$ResetDialog.visible = true
	

func _on_reset_dialog_confirmed() -> void:
	print("Resetting Track...")
	LevelController.LevelData = {
	"Level Info": {
	"Name": "Unnamed",
	"Description": "N/A",
	"Author": "Dev",
	"Song": "res://Music/Alone With Me - Good Kid.mp3",
	"Artist": "N/A",
	"SongFile": "N/A",
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
	print("Reset LevelController.LevelData")
	LevelController.SavedLevelData = {}
	print("Reset LevelController.SavedLevelData")
	print("Reloading scene...")
	get_tree().reload_current_scene()
