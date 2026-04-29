extends Area2D


var Speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Got tile ", position.x, position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += Speed * delta


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouse:
		queue_free()
