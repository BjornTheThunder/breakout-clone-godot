extends CharacterBody2D

@export var acceleration: int = 2500
@export var max_speed: int = 500
@export var friction: int = 2000
const POSITION_Y: int = 900

var input: Vector2 = Vector2.ZERO

var size: int = 0

func _ready() -> void:
	GameManager.show_hud()
	GameManager.play_music()
	GameManager.save_score()

func _process(delta: float) -> void:
	position.y = POSITION_Y
	player_movement(delta)

func get_input() -> void:
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

func player_movement(delta: float) -> void:
	get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()

func hit() -> void:
	GameManager.camera_shake(1)
	$HitSound.play()
	if size == 0:
		$AnimationPlayer.play("hit_animation")
	elif size == 1:
		$AnimationPlayer.play("medium_hit_animation")
	else:
		$AnimationPlayer.play("big_hit_animation")

func increase_size() -> void:
	if size == 2:
		return
	
	size += 1
	if size == 1:
		$AnimationPlayer.play("from_small_to_medium")
	elif size == 2:
		$AnimationPlayer.play("from_medium_to_big")

func increase_speed() -> void:
	max_speed += 200
	acceleration += 400
	friction += 800
