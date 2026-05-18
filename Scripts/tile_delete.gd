extends AudioStreamPlayer

func _on_tile_placer_delete() -> void:
	play()

func _on_tile_placer_flick_delete() -> void:
	play()


func _on_tile_placer_slider_delete() -> void:
	play()
