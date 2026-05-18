extends VSlider


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if PlayButton.Speed != 0:
		visible = false
	else:
		visible = true
