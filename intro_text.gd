extends Label
@onready var intro_text: Label = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(intro_text, "scale", Vector2(2, 2), 2).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(intro_text, "modulate", Color(1.0, 1.0, 1.0, 0.0), 2).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/home_page.tscn")
