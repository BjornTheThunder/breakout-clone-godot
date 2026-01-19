extends Node2D

func _ready() -> void:
	if GameManager.background_type == "base":
		var back = GameManager.background_scene.instantiate()
		add_child.call_deferred(back)
	elif GameManager.background_type == "space":
		var back = GameManager.space_background_scene.instantiate()
		add_child.call_deferred(back)
	elif GameManager.background_type == "vaporwave":
		var back = GameManager.vaporwave_background_scene.instantiate()
		add_child.call_deferred(back)
	elif GameManager.background_type == "fantasy":
		var back = GameManager.fantasy_tileset_background_scene.instantiate()
		add_child.call_deferred(back)
