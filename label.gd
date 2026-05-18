extends Label

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while true:
		await sleep(0.5)
		text = "Loading"
		await sleep(0.5)
		text = "Loading."
		await sleep(0.5)
		text = "Loading.."
		await sleep(0.5)
		text = "Loading..."
