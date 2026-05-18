extends CheckButton
var SnapX = true

func _on_toggled(toggled_on: bool):
	TileSnapX.SnapX = toggled_on
	print("Snap?", SnapX)
