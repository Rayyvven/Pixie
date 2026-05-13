extends CheckButton
var SnapY = true

func _on_toggled(toggled_on: bool):
	TileSnap.SnapY = toggled_on
	print("Snap?", SnapY)
