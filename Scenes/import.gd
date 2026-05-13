extends Button
signal LoadLevel(dir: String)

func _on_file_dialog_dir_selected(dir: String) -> void:
	#get_tree().reload_current_scene()
	print("Emitted Signal!")
	LoadLevel.emit(dir)


func _on_pressed() -> void:
	if $FileDialog.visible == false:
		$FileDialog.visible = true
	else:
		$FileDialog.visible = false
