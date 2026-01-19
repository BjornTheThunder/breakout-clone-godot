extends Node2D


func _on_dead_zone_body_entered(body: Node2D) -> void:
	GameManager.decrease_life()
