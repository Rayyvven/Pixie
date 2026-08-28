extends CheckButton

@onready var tile_snap: CheckButton = $"../../Row 2/TileSnap"

func _on_toggled(toggled_on: bool) -> void:
	LevelController.SnapTilesToBPM = toggled_on
	if toggled_on:
		tile_snap.button_pressed = false
		TileSnap.SnapY = false
