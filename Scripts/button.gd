extends Button
@onready var change_log_base: ColorRect = $".."

func _on_pressed() -> void:
	change_log_base.visible = false
