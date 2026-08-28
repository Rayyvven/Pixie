extends TextureButton

@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var speed_val: LineEdit = $"../../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var pause: TextureButton = $"../Pause"
@onready var music: AudioStreamPlayer = $"../../../Music"
@onready var play_position: Button = $"../../../PlayPosition"
@onready var tile_select: TextureButton = $"../../TileSelect"
@export var startfrom : float
@export var Speed: int
func _on_pressed() -> void:
	if tile_select.tog == true:
		tile_select.pressed.emit()
	pause.paused = false
	PlayButton.Speed = speed_val.speed
	Speed = speed_val.speed
	print(Speed)
	print(play_position.position.y/speed_val.speed)
	print("seeking to...", startfrom)
