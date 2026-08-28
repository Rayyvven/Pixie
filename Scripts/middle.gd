extends TextureButton
@onready var scale_control: VSlider = $"../ScaleControl"
@onready var slide_tile_base: Button = $"../SlideTileBase"

func _process(delta: float) -> void:
	scale.y = scale_control.value * -1
	slide_tile_base.scale.y = (scale_control.value/2) +.6 #-90
