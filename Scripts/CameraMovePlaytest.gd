extends Camera2D
@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var pause_menu: Panel = $PlaytestPause/PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	v_scroll_bar.max_value = LevelController.LevelData["Level Info"]["Length"]
	v_scroll_bar.value = v_scroll_bar.max_value
	position.y = v_scroll_bar.value
	print("Speed: ", LevelController.LevelData["Level Info"]["Speed"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var S = LevelController.LevelData["Level Info"]["Speed"]
	position.y -= float(S) * delta
	#position.y = v_scroll_bar.value * delta
	#if pause_menu.visible == false:
		#v_scroll_bar.value -= float(S) * delta
	
