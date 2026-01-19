extends Area2D

var fall_speed: int = 200

func _process(delta: float) -> void:
	position.y += fall_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("increase_speed"):
		body.increase_speed()
	
	GameManager.increase_points(12)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("death_animation")
	fall_speed = 0
	$PowerupSound.play()
	await $PowerupSound.finished
	queue_free()
