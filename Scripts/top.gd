extends TextureButton
@onready var scale_control: VSlider = $"../ScaleControl"
@onready var slide_tile_base: Button = $"../SlideTileBase"
@onready var nod: Node2D = $".."

func _process(delta: float) -> void:
	position.y = (scale_control.value * -210) - 232




func _on_mouse_entered() -> void:
	print("Holy GLORP???????????????????????/")
	if slide_tile_base.button_pressed:
		var tween = get_tree().create_tween()
		tween.tween_property(nod, "scale", Vector2(.75, .75), .5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(nod, "modulate", Color.TRANSPARENT, .5)
		tween.tween_callback(nod.queue_free)
