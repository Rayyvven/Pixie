extends TextureButton
signal Change_Page(page)
@export var page = 0
@onready var page_turn: AudioStreamPlayer2D = $"../PageTurn"


	
func _on_button_down() -> void:
	page -= 1
	emit_signal("Change_Page", page)
	print(page)
	page_turn.play()
