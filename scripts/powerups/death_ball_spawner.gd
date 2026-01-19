extends Node2D

@onready var death_ball_scene = preload("res://scenes/powerups/death_ball.tscn")

func _ready() -> void:
	for num in range(3):
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 1.3)
		$AudioStreamPlayer2D.play()
		var ball = death_ball_scene.instantiate()
		ball.position = position
		get_parent().call_deferred("add_child", ball)
		await get_tree().create_timer(2).timeout
	
	$GPUParticles2D.emitting = false
	await get_tree().create_timer(1).timeout
	queue_free()
