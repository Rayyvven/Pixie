extends TextureButton
class_name ThemedTextureButton
## Used only to load a scene on button press. 
@export var SceneToLoad: String
## The "Custom" bool overrides the SceneToLoad variable. This
## is used for buttons that have a custom script (E.G: the
## track delete button)
@export var Custom: bool
## The "Options" bool simply allows you to specify if the
## button is an options button (does it open the options
## menu?)
@export var Options: bool
## Required for options buttons.
@export var Canvas: CanvasLayer
var tween := Tween.new()

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
	## Should avoid potential soft-locks.
	if SceneToLoad != "" or Custom or Options:
		self.pressed.connect(on_pressed)
		
func on_pressed():
	if Options:
		var OptionsMenu = preload("uid://rx3yg8kvrsic").instantiate()
		Canvas.add_child(OptionsMenu)
		print("Opening Options")
	elif !Custom:
		Load.LoadScene(self.SceneToLoad)

## Button effects, these are here to make it consistant.
func _on_mouse_entered() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	tween.kill()
	var tween := get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), .25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
