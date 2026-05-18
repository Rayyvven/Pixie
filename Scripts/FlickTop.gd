extends TextureRect
@onready var rotate: HSlider = $"../Rotate"

func _process(delta: float) -> void:
	rotation_degrees = rotate.value
