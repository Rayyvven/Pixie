extends Label

@onready var SPDBAR: HScrollBar = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Speed" + "\n" + str(SPDBAR.value)
