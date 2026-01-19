extends Area2D

var fall_speed: int = 200

func _process(delta: float) -> void:
	position.y += fall_speed * delta

func _on_body_entered(body: Node2D) -> void:
	GameManager.increase_life()
	GameManager.increase_points(12)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("death_animation")
	fall_speed = 0
	$PowerupSound.play()
	await $PowerupSound.finished
	queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
