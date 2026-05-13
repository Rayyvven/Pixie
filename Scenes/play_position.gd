extends Button

@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var play: TextureButton = $"../Camera2D/Play"
@onready var pause: TextureButton = $"../Camera2D/Pause"
@onready var music: AudioStreamPlayer2D = $"../Camera2D/AudioStreamPlayer2D"
@onready var speed_val: LineEdit = $"../Camera2D/Options/OptionsMenu/SpeedVal"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 720.0 + v_scroll_bar.value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if play.Speed != 0:
		#print("weeeeeeeeee")
		position.y -= play.Speed * delta
	elif dragging == true and get_global_mouse_position().y < 100720:
		position.y = get_global_mouse_position().y - offset

var startfrom = 0.0


var offset = 0.0
var dragging = false
func _on_button_down() -> void:
	offset = get_global_mouse_position().y - global_position.y
	dragging = true
	print("dragging PlayPosition...", global_position)

func _on_button_up() -> void:
	dragging = false


func _on_play_pressed() -> void:
	position.y = 720.0 + v_scroll_bar.value
	play.Speed = speed_val.speed
	### Camera Position: Max 10,000 (Changable), Min 0. 
	### Speed: Speed/s
	### Seek: Camera Position & Speed
	### Calculation: ((Camera Position/Max Value) -1) * Speed
	
	#if play.Speed != 0:
	startfrom = (%VScrollBar.max_value - (position.y - 720.00))/int(speed_val.text)
	#else:
		#pass ## I'll add an easter egg eventually.
	
	##startfrom = 199 - (position.y/(%VScrollBar.max_value+720))*(200.0-720/play.Speed) ## This is disgusting AND NON-FUNCTIONAL. WHO COULD'VE GUESSED????
	if startfrom < 0:
		startfrom *= -1
	music.play()
	music.seek(startfrom)
	print("Seeking to...", startfrom)


func _on_pause_pressed() -> void:
	startfrom = (%VScrollBar.max_value - (position.y - 720.00))/int(speed_val.text)
	if pause.paused == false:
			music.stream_paused = false
			music.play()
			music.seek(startfrom)
	else:
		music.stream_paused = true
