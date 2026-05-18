extends TextureButton
@onready var scale_control: VSlider = $"../ScaleControl"

func _process(delta: float) -> void:
	position.y = (scale_control.value * -210) - 112
