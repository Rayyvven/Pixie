extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var particles = $GPUParticles2D
	var particles2 = $GPUParticles2D2
	$Tapped.play()
	particles.restart()
	particles2.restart()
	await get_tree().create_timer(3.0).timeout
	queue_free()
