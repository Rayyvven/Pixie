extends TextureButton

@onready var changelog: ColorRect = $"../ChangeLogBase"

func _on_pressed() -> void:
	if changelog.visible == false:
		changelog.visible = true
	else:
		changelog.visible = false
