extends Control
@onready var panel: Panel = $Panel
@onready var blur: ColorRect = $Panel/Blur



func _ready() -> void:
	panel.scale = Vector2(0.2, 0.2)
	var tween := get_tree().create_tween()
	tween.tween_property(panel, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(blur.material, "shader_parameters/blur_amount", 0, .25)#.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
