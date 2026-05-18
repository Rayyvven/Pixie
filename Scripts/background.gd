extends ColorRect

@onready var background_color_picker: ColorPicker = $"../Options/OptionsMenu/BackgroundColorPicker"
@onready var camera_2d: Camera2D = $".."


func _on_background_color_picker_color_changed(color: Color) -> void:
	print("Original Color:", color)
	set_color(background_color_picker.color)
	color = background_color_picker.color
	print("color changed to", background_color_picker.color)
