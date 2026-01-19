extends RigidBody2D

@export var speed: int = 550
var direction: Vector2
var can_move: bool = false

func _physics_process(delta: float) -> void:
	#lock direction to 4 angles
	lock_direction()
	
	if Input.is_action_pressed("primary action") and !can_move:
		direction = Vector2(1, -1)
		$GPUParticles2D.emitting = false
		can_move = true
	
	if can_move:
		linear_velocity = direction * speed
	else:
		linear_velocity = Vector2.ZERO

func lock_direction() -> void:
	direction = linear_velocity.normalized()
	if direction.y < 0:
		direction.y = -1
	else:
		direction.y = 1
	if direction.x < 0:
		direction.x = -1
	else:
		direction.x = 1
	direction = direction.normalized()


func _on_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		body.call_deferred("hit")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$GPUParticles2D.emitting = true
	if GameManager.is_game_over:
		queue_free()
	can_move = false
	linear_velocity = Vector2.ZERO
