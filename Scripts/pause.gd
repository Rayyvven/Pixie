extends TextureButton

@onready var play: TextureButton = $"../Play"
@onready var music: AudioStreamPlayer = $"../../../Music"
@onready var speed_val: LineEdit = $"../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var animation_player: AnimationPlayer = $"../../TileSelect/AnimationPlayer"
@onready var tile_select: TextureButton = $"../../TileSelect"
@export var paused : bool = false

func _on_pressed() -> void:
	if music.stream_paused == false:
		PlayButton.Speed = 0
		play.Speed = 0
		paused = true
	else:
		PlayButton.Speed = speed_val.speed
		play.Speed = speed_val.speed
		paused = false
