extends Button

func _on_button_down() -> void:
	if $FileDialog.visible == false:
		$FileDialog.visible = true
	else:
		$FileDialog.visible = false
