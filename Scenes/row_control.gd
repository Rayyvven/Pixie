extends LineEdit


func _ready() -> void:
	var Options = ConfigFile.new()
	var err = Options.load("user://options.cfg")
	if Options.get_value("Editor", "UpdatedRowCalculation") == true:
		visible = true
	else:
		visible = false
