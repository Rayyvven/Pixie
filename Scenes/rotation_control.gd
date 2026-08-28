extends HSlider


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if PlayButton.Speed != 0:
		visible = false
	else:
		visible = true
	if get_global_mouse_position().x >= 1000 or EditorOptionsGlobal.Shown == true or get_viewport().get_mouse_position().y >= 1700 or get_viewport().get_mouse_position().y <= 150 and get_viewport().get_mouse_position().x <= 150 or EditorOptionsGlobal.Shown:
		mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
		#print("Disabled Tile")
		modulate.a = .5
	else:
		mouse_filter = MouseFilter.MOUSE_FILTER_STOP
		modulate.a = 1
