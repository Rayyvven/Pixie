extends LineEdit

@export var speed : int = 500

func _process(delta: float) -> void:
	speed = int(text)


func _on_text_submitted(new_text: String) -> void:
		LevelController.LevelData["Level Info"]["Speed"] = new_text
		if int(text) < 0:
			print("Thing is below 0 oh no")
