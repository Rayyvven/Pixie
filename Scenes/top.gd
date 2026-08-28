extends TextureRect
@onready var rotate: HSlider = $"../Rotate"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees = rotate.value
