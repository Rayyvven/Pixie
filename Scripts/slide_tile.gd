extends TextureButton
@onready var cont: VSlider = $"../Scale"

func _process(delta: float) -> void:
	scale.y = cont.value * -1
