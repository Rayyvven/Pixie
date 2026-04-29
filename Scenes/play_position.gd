extends ColorRect

@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var play: TextureButton = $"../Camera2D/Play"
@onready var pause: TextureButton = $"../Camera2D/Pause"
@onready var music: AudioStreamPlayer2D = $"../Camera2D/AudioStreamPlayer2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 720.0 + v_scroll_bar.value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if play.Speed != 0:
		#print("weeeeeeeeee")
		position.y -= play.Speed * delta
	else:
		pass

var startfrom = 0.0
func _on_play_button_down() -> void:
	position.y = 720.0 + v_scroll_bar.value
	startfrom = 199 - (position.y/(%VScrollBar.max_value+720))*(200.0-720/play.Speed) ## This is disgusting
	if startfrom < 0:
		startfrom *= -1
	music.seek(startfrom)
