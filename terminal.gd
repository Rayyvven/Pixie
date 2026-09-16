extends Control
@onready var output: RichTextLabel = $VBoxContainer/Output
@onready var input: LineEdit = $VBoxContainer/Input

func append(text: String):
	output.text += text + "\n"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	append("This is the developer terminal")
	append("Run command 'help' for a list of commands")

func RunCommand(Unsplit: String, InputA: String, InputB: String):
	pass
func _on_input_text_submitted(new_text: String) -> void:
	input.clear()
	match new_text.to_lower():
		"help":
			append("Commands:")
			append("help: shows list of current commands")
		"scenes":
			append("Getting scenes...")
