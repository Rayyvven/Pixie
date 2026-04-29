extends TextureButton

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var tog = false

func _on_button_down() -> void:
	print("Toggled")
	if tog == true:
		animation_player.play("HideTiles")
		print("Playing animation ShowTiles")
		self_modulate.r = 1
		self_modulate.b = 1
		self_modulate.g = 1
		tog = false
		$CardPutDown.play()
	else:
		animation_player.play("ShowTiles")
		print("Playing reversed animation")
		tog = true
		self_modulate.r = 0.75
		self_modulate.b = 0.75
		self_modulate.g = 0.75
		$CardPickUp.play()
