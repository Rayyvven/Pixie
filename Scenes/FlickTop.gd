extends TextureRect
@onready var rotate: HSlider = $"../Rotate"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees = rotate.value
