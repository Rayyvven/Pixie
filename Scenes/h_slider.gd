extends HSlider

@onready var background_blur: ColorRect = $"../../../../../../../../../BackgroundControl/BackgroundBlur"

func _on_value_changed(value: float) -> void:
	background_blur.material.set_shader_parameter("blur_amount", value)
	print(background_blur.material.get_shader_parameter("blur_amount"))
