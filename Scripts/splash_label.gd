extends Label
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
### TODO: Convert this into a .JSON or .TXT file for easier modification
var SplashList = []
func _ready() -> void:
	animation_player.play("SplashTextLoop")
	var SplashFile = FileAccess.open("res://Assets/SplashTexts.txt", FileAccess.READ)

	while not SplashFile.eof_reached():
		var line = SplashFile.get_line()
		SplashList.append(line)
	print("Got ", len(SplashList), " Splash Texts")
	text = SplashList.pick_random()
