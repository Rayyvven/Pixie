extends Control
@onready var titlelabel: Label = $AlertPanel/Title
@onready var contentslabel: Label = $AlertPanel/Contents
@onready var alert_panel: Panel = $AlertPanel

func Alert(title: String, contents: String):
	print("Alert: ", title, ": ", contents)
	alert_panel.scale = Vector2(0.1, 0.1)
	titlelabel.text = title
	contentslabel.text = contents
	var tween := get_tree().create_tween()
	tween.tween_property(alert_panel, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
