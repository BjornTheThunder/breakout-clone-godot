extends Node2D

@export var brick_scene: PackedScene
@export var stone_brick_scene: PackedScene
@export var health_brick_scene: PackedScene
@export var paddle_brick_scene: PackedScene
@export var speed_brick_scene: PackedScene
@export var fire_brick_scene: PackedScene
@export var death_brick_scene: PackedScene

@export var columns: int = 10
@export var rows: int = 10
@export var offset: int = 10

var column_position: int
var row_position: int

#This object can be used for a kind of endless mode

func _ready() -> void:
	GameManager.max_number_of_blocks = (columns * rows)
	row_position = position.y
	column_position = position.x
	spawn_bricks()

func spawn_bricks() -> void:
	var brick
	
	#this is hardcoded, this is bad
	for row in rows:
		for column in columns:
			if randi_range(0, 100) < 3:
				brick = paddle_brick_scene.instantiate()
			elif randi_range(0, 100) < 4:
				brick = speed_brick_scene.instantiate()
			elif randi_range(0, 100) < 1:
				brick = health_brick_scene.instantiate()
			elif randi_range(0, 100) < 3:
				brick = fire_brick_scene.instantiate()
			elif randi_range(0, 100) < floor(GameManager.number_of_repeats / 2):
				brick = death_brick_scene.instantiate()
			elif randi_range(0, 100) < (15 * GameManager.number_of_repeats):
				brick = stone_brick_scene.instantiate()
			else:
				brick = brick_scene.instantiate()
			brick.position = Vector2(column_position, row_position)
			add_child(brick)
			column_position += offset
		column_position = position.x
		row_position += offset
