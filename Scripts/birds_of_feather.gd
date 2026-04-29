extends Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"




func _on_right_page_change_page(page: Variant) -> void:
	if page != 0:
		$BirdsOfAFeatherCard.visible = 0
		visible = false
		audio_stream_player_2d.stop()
	else:
		$BirdsOfAFeatherCard.visible = true
		visible = true
		audio_stream_player_2d.play()
func _on_left_page_change_page(page: Variant) -> void:
	if page != 0:
		$BirdsOfAFeatherCard.visible = 0
		visible = false
		audio_stream_player_2d.stop()
	else:
		$BirdsOfAFeatherCard.visible = true
		visible = true
		audio_stream_player_2d.play()
