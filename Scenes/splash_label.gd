extends Label
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var SplashText = [
	"Welcome to Pixie!",
	"Don't trust Palm Beach Pete",
	"Also play MineCraft!",
	"Think fast!",
	"Est. April 17th",
	"This is a splash text!",
	"Game of the Year 1738!",
	"0.81818181818...!",
	"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
	"Are you sure?",
	"Glungus says hi",
	"Hold your horses!",
	"Super super gay update coming soon",
	"You are going to Brazil",
	"Today is October 3rd, 2028!",
	"Curnox57 is a fraud",
	":3",
	"I miss my wife!",
	"You know what that means!",
	"FISH",
	"The distance between the bottom of New Zealand and Antarctica is shorter than the height of the USA!",
	"U da real art",
	"Meloncholy is short!",
	"> Horse walks in",
	"Hi lol",
	"The big J.P. is calling",
	"Can we hang out sometime?",
	"Can you believe it guys?",
	"Do you wear wigs?",
	"Happy birthday!",
	"."
	
	
]
func _ready() -> void:
	animation_player.play("SplashTextLoop")
	text = SplashText.pick_random()
	
