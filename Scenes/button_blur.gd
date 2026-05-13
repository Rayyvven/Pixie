extends ColorRect


var Ent = false


func _on_mouse_entered() -> void:
	ButtonBlur.Ent = true


func _on_mouse_exited() -> void:
	ButtonBlur.Ent = false
