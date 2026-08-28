extends CheckButton

@onready var tile_snap_bpm: CheckButton = $"../../Row 3/TileSnapBPM"
var SnapY = true

func _on_toggled(toggled_on: bool):
	TileSnap.SnapY = toggled_on
	if toggled_on:
		tile_snap_bpm.button_pressed = false
	print("Snap?", SnapY)
