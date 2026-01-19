extends StaticBody2D
class_name Brick

@export var powerup_scene: PackedScene
@export var spawn_probability: int = 25

@export var brick_health = 0
@export var points = 2
@export var camera_shake_power = 3

var can_spawn: bool = true

func hit() -> void:
	GameManager.increase_block_counter()
	GameManager.camera_shake(1)
	brick_health -= 1
	if brick_health < 0 and can_spawn:
		$CollisionShape2D.call_deferred("set_disabled", true)
		can_spawn = false
		GameManager.camera_shake(camera_shake_power)
		$AnimationPlayer.play("death_animation")
		if powerup_scene != null:
			if randi_range(0, 100) < spawn_probability:
				var powerup = powerup_scene.instantiate()
				powerup.position = position
				get_parent().call_deferred("add_child", powerup)
		
		GameManager.play_brick_break_sound()
		GameManager.increase_points(points)
	
	if $AnimatedSprite2D != null:
		$AnimatedSprite2D.frame = brick_health
