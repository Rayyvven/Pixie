extends TextureButton

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tile_select: TextureButton = $"."
@onready var pause_menu: Control = %PauseMenu
@onready var options_menu: Control = %OptionsMenu
@export var tog = false

func _on_pressed() -> void:
	print("Toggled")
	if tile_select.tog == true:
		animation_player.play("HideTiles")
		print("Playing animation ShowTiles")
		self_modulate.r = 1
		self_modulate.b = 1
		self_modulate.g = 1
		tile_select.tog = false
		$CardPutDown.play()
	elif pause_menu.visible == false and options_menu.visible == false:
		if tile_select.tog == false:
			animation_player.play("ShowTiles")
			print("Playing reversed animation")
			tile_select.tog = true
			self_modulate.r = 0.75
			self_modulate.b = 0.75
			self_modulate.g = 0.75
			$CardPickUp.play()
