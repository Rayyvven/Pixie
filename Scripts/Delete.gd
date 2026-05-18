extends Button
@export var delete : bool = false
signal deletetile()

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		delete = true
		deletetile
		print("deltile")
	else:
		delete = false
		deletetile
		print("deltile")
