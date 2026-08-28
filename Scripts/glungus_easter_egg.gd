extends TextureRect

@onready var speed_val: LineEdit = $"../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var bpm_val: LineEdit = $"../OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/BPMVal"


func _process(delta: float) -> void:
	if speed_val.text == "0" or int(bpm_val.text) < 0:
		visible = true
	else:
		visible = false
