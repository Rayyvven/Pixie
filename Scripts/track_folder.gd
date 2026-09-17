extends TextureButton

### I am fully aware of a much more efficient way of creating buttons now.
### This button will use the old method while I work on fixing the many issues
### Pixie currently has. Cheers
# Called when the node enters the scene tree for the first time.

var tween := Tween.new()
func _on_mouse_entered() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_pressed() -> void:
	print("Attempting to open user file...")
	OS.shell_open(OS.get_user_data_dir())
