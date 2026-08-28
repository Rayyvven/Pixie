extends Node

@onready var v_scroll_bar: VScrollBar = %VScrollBar
@onready var length_label: Label = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 3/SongFile/Length Label"
@onready var speed_val: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/SpeedVal"
@onready var bpm_node: Node2D = $"BPM Node"
@onready var bpm_line: ColorRect = $"BPM Line"
@onready var bpm_val: LineEdit = $"../CanvasLayer/OptionsMenu/OptionsPanel/MainVerticalContainer/Row 5/BPMVal"

func _on_bpm_val_text_changed(new_text: String) -> void:
	if int(new_text) <= 0:
		print("No.")
	else:
		LevelController.BPM = int(new_text)
		print("Attempting to remove children...")
		var children = bpm_node.get_children()
		for child in children:
			child.queue_free()
			print("Removed Child")
		var BPS = float(new_text)/60
		var To_Place = float(speed_val.text)/BPS
		print("Length: ", length_label.length)
		print("Speed: ", speed_val.text)
		print("Beats Per Second: ", BPS)
		print("BPM To Place: ", To_Place)
		var BPMLine = bpm_line.duplicate()
		var Pos = length_label.length * float(speed_val.text)
		while Pos > 0:
			BPMLine = bpm_line.duplicate()
			BPMLine.visible = true
			BPMLine.position.y = Pos
			bpm_node.add_child(BPMLine)
			print("Added Child at: ", Pos)
			Pos -= To_Place
