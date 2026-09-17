extends ColorRect
### Unfortunately this might have to be the only way...

func _process(delta: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "size", Vector2(self.size.x, 1920 * Load.progress[0]), .1)#.set_trans(Tween.TRANS_ELASTIC)
	
	#size.y = 1920 * Load.progress[0]
