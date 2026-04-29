extends Camera2D
@onready var options_menu: Node2D = %OptionsMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if options_menu.visible == false:
		position.y = %VScrollBar.value
	else:
		position.y = 10000000


func _on_play_button_down() -> void:
	pass # Replace with function body.
