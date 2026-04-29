extends TextureButton
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var speed_val: LineEdit = $"../Options/OptionsMenu/SpeedVal"
@onready var pause: TextureButton = $"../Pause"
@onready var play_position: ColorRect = $"../../PlayPosition"
@export var startfrom : float
@export var Speed: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@onready var v_scroll_bar: VScrollBar = %VScrollBar


func _on_button_down() -> void:
	#%VScrollBar.value = %VScrollBar.max_value
	pause.paused = false
	Speed = speed_val.speed
	print(Speed)
	#startfrom = 199 - (play_position.position.y/(%VScrollBar.max_value+720))*(200.0-720/speed_val.speed) ## This is disgusting
	#startfrom = ((play_position.position.y - 720)/speed_val.speed)
	print(play_position.position.y/speed_val.speed)
	#if startfrom < 0:
		#startfrom *= -1
	music.play()
	#music.seek(startfrom)
	print("seeking to...", startfrom)
