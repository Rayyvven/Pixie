extends TextureButton

func _on_pressed() -> void:
	LevelController.LevelData = LevelController.DefaultLevelData
	LevelController.SavedLevelData = LevelController.DefaultLevelData
	print("Reset LevelData & SavedLevelData")
	Load.LoadScene("res://Scenes/editor.tscn")
@onready var editor: TextureButton = $"."

var tween := Tween.new()
func _on_mouse_entered() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(editor, "scale", Vector2(1.1, 1.1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(editor, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
