extends VScrollBar
@onready var play: TextureButton = $"../Play"
@onready var speed_control: HScrollBar = $"../Options/OptionsMenu/SpeedControl"
@onready var speed_val: LineEdit = $"../Options/OptionsMenu/SpeedVal"


func _process(delta: float) -> void:
	#if play.Speed != 0:
		#value -= speed_val.speed * delta
		#visible = false
	#else:
		#visible = true
	pass
