extends CheckButton

var DragSmooth = true

func _on_toggled(toggled_on: bool) -> void:
	SmoothDrag.DragSmooth = toggled_on
