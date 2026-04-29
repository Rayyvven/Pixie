extends TextureButton
@onready var play_position: ColorRect = $"../../PlayPosition"
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var play: TextureButton = $"../Play"
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"




func _on_button_down() -> void:
	play_position.position.y = 720.0 + v_scroll_bar.value
	play.Speed = 0
	music.stop()
