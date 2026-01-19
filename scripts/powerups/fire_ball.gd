extends Area2D

@export var speed: int = 100

func _ready() -> void:
	rotation_degrees = randi_range(-180, 180)

func _process(delta: float) -> void:
	position += Vector2.UP.rotated(rotation) * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()
