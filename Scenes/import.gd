extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_button_down() -> void:
	if $FileDialog.visible == false:
		$FileDialog.visible = true
	else:
		$FileDialog.visible = false
