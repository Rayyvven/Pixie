extends Node2D
@onready var basic_tile: TextureButton = $BasicTile



func _on_basic_tile_button_down() -> void:
	var tween = get_tree().create_tween()
	Input.vibrate_handheld(100, 0.15)
	tween.tween_property(basic_tile, "scale", Vector2(.75, .75), .5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(basic_tile, "modulate", Color.TRANSPARENT, .5)
	tween.tween_callback(basic_tile.queue_free)
