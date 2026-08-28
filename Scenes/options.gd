extends TextureButton
@onready var canvas_layer: CanvasLayer = $"../.."

@onready var options_panel: Panel = $"../../OptionsPanel"

func _on_toggled(toggled_on: bool) -> void:
	print("Options Toggled: ", toggled_on)
	var OptionsMenu = preload("uid://rx3yg8kvrsic").instantiate()
	canvas_layer.add_child(OptionsMenu)
