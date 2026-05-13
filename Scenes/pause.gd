extends TextureButton
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var play: TextureButton = $"../Play"
@export var paused : bool = false
@onready var speed_val: LineEdit = $"../Options/OptionsMenu/SpeedVal"

func _on_pressed() -> void:
	if music.stream_paused == false:
		#music.stream_paused = true
		PlayButton.Speed = 0
		play.Speed = 0
		paused = true
	else:
		#music.stream_paused = false
		PlayButton.Speed = speed_val.speed
		play.Speed = speed_val.speed
		paused = false
