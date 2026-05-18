extends LineEdit
@onready var speed_val: LineEdit = $"."

@export var speed : int = 500

func _process(delta: float) -> void:
	speed_val.speed = int(text)

func _ready() -> void:
	if str(LevelController.LevelData["Level Info"]["Speed"]) == "1":
		LevelController.LevelData["Level Info"]["Speed"] = text
	else: ## None of this works. Please, for the love of god, fix this later.
		LevelController.LevelData["Level Info"]["Speed"] = speed
		text = str(LevelController.LevelData["Level Info"]["Speed"])

func _on_text_submitted(new_text: String) -> void:
		LevelController.LevelData["Level Info"]["Speed"] = new_text
		if int(text) < 0:
			print("Thing is below 0 oh no")
