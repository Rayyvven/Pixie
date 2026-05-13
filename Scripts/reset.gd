extends Node2D


func _ready() -> void:
	var particles = $GPUParticles2D
	var particles2 = $GPUParticles2D2
	$Tapped.play()
	particles.restart()
	particles2.restart()
	await get_tree().create_timer(3.0).timeout
	queue_free()
