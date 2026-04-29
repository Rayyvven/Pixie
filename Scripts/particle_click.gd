extends Node2D

@export var particle_click: PackedScene

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var vfx = particle_click.instantiate()
		vfx.position = get_global_mouse_position()
		add_child(vfx)
