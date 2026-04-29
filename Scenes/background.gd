extends ColorRect

@onready var background_color_picker: ColorPicker = $"../Options/OptionsMenu/BackgroundColorPicker"
@onready var camera_2d: Camera2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_background_color_picker_color_changed(color: Color) -> void:
	print("Original Color:", color)
	set_color(background_color_picker.color)
	color = background_color_picker.color
	print("color changed to", background_color_picker.color)
