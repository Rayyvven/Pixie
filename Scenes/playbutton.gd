extends TextureButton
@onready var play: TextureButton = $"."
@onready var home_page: Node2D = $"../../../.."
var tween := Tween.new()
func _on_mouse_entered() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(play, "scale", Vector2(1.1, 1.1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(play, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
