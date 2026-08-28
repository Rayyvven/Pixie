extends Button

@onready var play: TextureButton = $"../CanvasLayer/Yikes/Play"
@onready var pause: TextureButton = $"../CanvasLayer/Yikes/Pause"
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var music: AudioStreamPlayer = $"../Music"
@onready var speed_val: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var background_video: VideoStreamPlayer = $"../BackgroundControl/BackgroundVideo"


var startfrom = 0.0
var offset = 0.0
var dragging = false

func _ready() -> void:
	await get_tree().process_frame 
	position.y = 720.0 + v_scroll_bar.value

func _process(delta: float) -> void:
	if play.Speed != 0:
		position.y -= play.Speed * delta
	elif dragging == true:
		position.y = get_global_mouse_position().y - offset
		if position.y > 720.0 + v_scroll_bar.value:
			position.y = 720.0 + v_scroll_bar.value
	
func _on_button_down() -> void:
	offset = get_global_mouse_position().y - global_position.y
	dragging = true
	print("dragging PlayPosition...", global_position)

func _on_button_up() -> void:
	dragging = false

func _on_play_pressed() -> void:
	position.y = 720.0 + v_scroll_bar.value
	play.Speed = speed_val.speed
	startfrom = (%VScrollBar.max_value - (position.y - 720.00))/int(speed_val.text) ## This was a huge calculation I had to use Desmos for.
	
	## Song Length: 8 sec
	## At position 4000, seek to point 8 (speed/position)
	#startfrom = (position.y - 720.00/int(speed_val.text))
	
	if startfrom < 0:
		startfrom *= -1
	music.play()
	music.seek(startfrom)
	background_video.play()
	background_video.set_stream_position(startfrom)
	print("Seeking to...", startfrom)

func _on_pause_pressed() -> void:
	startfrom = (%VScrollBar.max_value - (position.y - 720.00))/int(speed_val.text)
	if pause.paused == false:
			music.stream_paused = false
			music.play()
			music.seek(startfrom)
			background_video.play()
			background_video.set_stream_position(startfrom)
	else:
		music.stream_paused = true
		background_video.paused = true

func _on_bpm_val_text_changed(new_text: String) -> void:
	position.y = 720.0 + v_scroll_bar.value
