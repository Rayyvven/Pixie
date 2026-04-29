extends TextureButton
@onready var music: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@export var Shown : bool = false



func _on_toggled(toggled_on: bool) -> void:
	if $OptionsMenu.visible == false:
		$OptionsMenu.visible = true
		music.bus = "MenuMusic"
		Shown = true
		print(Shown)
	else:
		$OptionsMenu.visible = false
		music.bus = "LevelMusic"
		Shown = false
		print(Shown)
