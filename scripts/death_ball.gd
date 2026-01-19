extends RigidBody2D

@export var speed: int = 600
var direction: Vector2

func _ready() -> void:
	direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))

func _physics_process(delta: float) -> void:
	#lock direction to 4 angles
	lock_direction()
	
	linear_velocity = direction * speed

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
	if body.has_method("hit") and body.is_in_group("Paddle"):
		body.call_deferred("hit")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$AnimationPlayer.play("disappear")

func _on_queue_free_timer_timeout() -> void:
	$AnimationPlayer.play("disappear")
