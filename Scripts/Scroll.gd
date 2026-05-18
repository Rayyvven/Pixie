extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scroll = VScrollBar.value
	print(scroll)
	position.y = position.y/scroll
