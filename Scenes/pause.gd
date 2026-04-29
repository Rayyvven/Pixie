extends TextureButton
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var play: TextureButton = $"../Play"
@export var paused : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.






func _on_button_down() -> void:
	if music.stream_paused == false:
		music.stream_paused = true
		play.Speed = 0
		paused = true
	else:
		music.stream_paused = false
		play.Speed = 500
		paused = false
