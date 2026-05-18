extends TextureRect
@onready var speed_val: LineEdit = $"../Options/OptionsMenu/SpeedVal"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if speed_val.text == "0":
		visible = true
	else:
		visible = false
