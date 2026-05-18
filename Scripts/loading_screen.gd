extends ColorRect

@onready var editor: TextureButton = $"../Editor"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if editor.scene_loading:
		while modulate.a != 100:
			modulate.a += 1 * delta
	else:
		while modulate.a != 0:
			modulate.a -= 1 * delta
