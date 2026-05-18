extends HSlider

func _process(delta: float) -> void:
	if PlayButton.Speed != 0:
		visible = false
	else:
		visible = true
