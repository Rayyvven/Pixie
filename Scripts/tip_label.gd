extends Label


var Tips = [
	"You can build custom tracks in the editor!",
	"Always make sure you look ahead. You never know what's coming!",
	"Go online to play custom levels made by other people!",
	"Join the Discord to talk to the game's creator!",
	"Check us out on GitHub!",
	"View our Wikipedia on GitHub to learn more about the game and how it works",
	"The game's creator loves Toblerones.",
	"Sync your levels to the beat using BPM lines.",
	
]
func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _ready() -> void:
	while true:
		text = Tips.pick_random()
		await sleep(3.0)
