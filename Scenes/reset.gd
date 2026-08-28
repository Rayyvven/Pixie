extends TextureButton

@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var play: TextureButton = $"../Yikes/Play"
@onready var music: AudioStreamPlayer = $"../../Music"
@onready var play_position: Button = $"../../PlayPosition"

func _on_pressed() -> void:
	play_position.position.y = v_scroll_bar.max_value + 720
	PlayButton.Speed = 0
	play.Speed = 0
	music.stop()
