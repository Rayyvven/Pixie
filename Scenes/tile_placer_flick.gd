extends Node2D

@onready var rotate: HSlider = $Rotate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var nod: Node2D = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


### On Pressed:
##### (do nothing, wait until mouse up)
##### Get angle
##### Get distance
##### If angle is within 10 degrees & distance >= 50




func _on_base_button_up() -> void:
	var angle = rad_to_deg(get_angle_to(get_global_mouse_position()))
	print("Angle: ", angle)
	var distance = (get_global_mouse_position().x - position.x) + (get_global_mouse_position().y - position.y)
	if distance < 0:
		distance *=-1
	print("Distance: ", distance)

	if angle >= rotate.value - 20 and angle <= rotate.value + 20 and distance >= 50:
		if angle and rotate.value < 0:
			angle *= -1
			rotate.value *= -1
			print("New Angle: ", angle)
		var tween = get_tree().create_tween()
		tween.tween_property(nod, "scale", Vector2(.75, .75), .5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(nod, "modulate", Color.TRANSPARENT, .5)
		tween.tween_callback(nod.queue_free)
	else:
		print("False!")
