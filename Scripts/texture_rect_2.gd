extends TextureRect

func _process(delta: float) -> void:
	rotation_degrees += 5 * delta
	
