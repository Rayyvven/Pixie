extends TextureButton
@onready var scale_control: VSlider = $"../ScaleControl"





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = (scale_control.value * -210) - 112
