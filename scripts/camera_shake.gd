extends Camera2D

@export var shake_fade: float = 5

var rng = RandomNumberGenerator.new()

var shake_strenght: float = 0

func apply_shake(strenght) -> void:
	shake_strenght = strenght

func _process(delta: float) -> void:
	if shake_strenght > 0:
		shake_strenght = lerpf(shake_strenght, 0, shake_fade * delta)
		
		offset = random_offset()

func random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_strenght, shake_strenght),
		rng.randf_range(-shake_strenght, shake_strenght)
	)
