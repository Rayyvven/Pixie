extends TextureButton
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var speed_val: LineEdit = $"../Options/OptionsMenu/SpeedVal"
@onready var pause: TextureButton = $"../Pause"

@export var startfrom : float
@export var Speed: int
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var play_position: Button = $"../../PlayPosition"
@onready var tile_select: TextureButton = $"../TileSelect"

func _on_pressed() -> void:
	if tile_select.tog == true:
		tile_select.button_down.emit()
	pause.paused = false
	PlayButton.Speed = speed_val.speed
	Speed = speed_val.speed
	print(Speed)
	print(play_position.position.y/speed_val.speed)

	print("seeking to...", startfrom)
