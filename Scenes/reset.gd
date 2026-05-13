extends TextureButton
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var play: TextureButton = $"../Play"
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var play_position: Button = $"../../PlayPosition"


func _on_pressed() -> void:
	play_position.position.y = 10720
	PlayButton.Speed = 0
	play.Speed = 0
	music.stop()
