extends LineEdit

@onready var speed_val: LineEdit = $"."
@export var speed : int = 500

func _ready() -> void:
	if str(LevelController.LevelData["Level Info"]["Speed"]) != text:
		text = str(LevelController.LevelData["Level Info"]["Speed"])
	else: ## None of this works. Please, for the love of god, fix this later. ## WHAT DO YOU MEAN NONE OF IT WORKS
		LevelController.LevelData["Level Info"]["Speed"] = text
		text = str(LevelController.LevelData["Level Info"]["Speed"])

func _on_text_changed(new_text: String) -> void:
		LevelController.LevelData["Level Info"]["Speed"] = new_text
		speed_val.speed = int(new_text)
		if int(text) < 0:
			print("Thing is below 0 oh no")
