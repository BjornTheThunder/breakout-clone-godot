extends Node

var lives: int = 6
var points: int = 0

var high_score: int
var save_path = "user://breakout_high_score.save"

var is_game_over = false
var number_of_repeats = 0
var max_number_of_blocks: int
var number_of_broken_blocks = 0

@onready var points_label: Label = $HUD/MarginContainer/Label
@onready var lives_label: Label = $HUD/MarginContainer2/Label
@onready var camera: Camera2D = $Camera2D
@onready var high_score_label: Label = $PauseMenu/MarginContainer/VBoxContainer/HighScoreText

@onready var change_level_timer: Timer = $HUD/ChangeLevelAnimation/ChangeLevelTimer
@onready var timer_label: Label = $HUD/ChangeLevelAnimation/TimerLabel
var is_change_level: bool = false

###COINS
var coins: int
var unlockables_save_path = "user://unlockables.save"

#MUSIC
var is_cyberpunk_bought: bool
var is_arcade_bought: bool
var is_hero_immortal_bought: bool
var is_lunar_echo_bought: bool
var is_sky_bought: bool

#BACKGROUND
var background_scene: PackedScene = preload("res://scenes/background.tscn")
var space_background_scene: PackedScene = preload("res://scenes/space_background.tscn")
var vaporwave_background_scene: PackedScene = preload("res://scenes/vaporwabe_background.tscn")
var fantasy_tileset_background_scene: PackedScene = preload("res://scenes/fantasy_background.tscn")

var is_space_background_bought: bool
var is_vaporwave_background_bought: bool
var is_fantasy_background_bought: bool

var background_type: String = "base"

#BALL EFFECTS

func _ready() -> void:
	load_score()
	load_unlockables_data()

func _process(delta: float) -> void:
	timer_label.text = "%.2f" % change_level_timer.time_left
	
	if Input.is_action_just_released("back") and get_tree().current_scene.name != "Menu" and !is_game_over:
		change_pause_menu_state()
		save_score()
		high_score_label.text = "HIGH SCORE: " + str(high_score)

func change_song(song: String) -> void:
	$MusicTheme.stream = load(song)

func play_music() -> void:
	$MusicTheme.play()

func stop_music() -> void:
	$MusicTheme.stop()

func increase_block_counter() -> void:
	number_of_broken_blocks += 1
	
	if number_of_broken_blocks >= (max_number_of_blocks - 80) and !is_change_level:
		is_change_level = true
		$HUD/ChangeLevelAnimation.show()
		change_level_timer.start()
	
	if number_of_broken_blocks >= max_number_of_blocks:
		is_change_level = false
		$HUD/ChangeLevelAnimation.hide()
		number_of_broken_blocks = 0
		number_of_repeats += 1
		get_tree().reload_current_scene()

func increase_points(amount: int) -> void:
	points += amount
	points_label.text = "SCORE: " + str(points)
	$AnimationPlayer.play("score_animation")

func decrease_life() -> void:
	lives -= 1
	if lives == 0:
		game_over()
	lives_label.text = "LIVES: " + str(lives)

func increase_life() -> void:
	lives += 1
	lives_label.text = "LIVES: " + str(lives)

func show_hud() -> void:
	$HUD.show()

func game_over() -> void:
	stop_music()
	save_score()
	$HUD/ChangeLevelAnimation.hide()
	$HUD/GameOver/VBoxContainer/HighScore.text = "HIGH SCORE: " + str(high_score)
	is_game_over = true
	coin_counter_animation()
	save_unlockables_data()
	get_tree().paused = true
	$HUD/GameOver.show()

func coin_counter_animation() -> void:
	var max_coins = floor(points / 25)
	var now_coins = 0
	GameManager.coins += max_coins
	
	while now_coins < max_coins:
		now_coins += 1
		await get_tree().create_timer(0.02).timeout
		$HUD/GameOver/VBoxContainer/CoinLabel.text = "COINS: +" + str(now_coins)
		$CoinSound.play()

func play_brick_break_sound() -> void:
	$BrickBreakSound.stop()
	$BrickBreakSound.play()

func play_click_gui_sound() -> void:
	$ClickSound.play()

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	is_game_over = false
	get_tree().paused = false
	$HUD/GameOver.hide()
	play_music()
	lives = 6
	points = 0
	number_of_repeats = 0
	points_label.text = "SCORE: " + str(points)
	lives_label.text = "LIVES: " + str(lives)

func camera_shake(strenght) -> void:
	camera.apply_shake(strenght)

#PAUSE MENU
func _on_resume_pressed() -> void:
	play_click_gui_sound()
	change_pause_menu_state()

func _on_exit_pressed() -> void:
	play_click_gui_sound()
	change_pause_menu_state()
	$HUD.hide()
	$MusicTheme.stop()
	lives = 6
	points = 0
	is_game_over = false
	number_of_repeats = 0
	points_label.text = "SCORE: " + str(points)
	lives_label.text = "LIVES: " + str(lives)
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

func change_pause_menu_state() -> void:
	$PauseMenu.visible = !$PauseMenu.visible
	get_tree().paused = !get_tree().paused

func save_score() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if points > high_score:
		high_score = points
		file.store_64(points)
	
	file.close()

func load_score() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		high_score = file.get_64()
		file.close()
	else:
		high_score = 0

func save_unlockables_data() -> void:
	var file = FileAccess.open(unlockables_save_path, FileAccess.WRITE)
	
	file.store_var(coins)
	
	#MUSIC
	file.store_var(is_cyberpunk_bought)
	file.store_var(is_arcade_bought)
	file.store_var(is_hero_immortal_bought)
	file.store_var(is_lunar_echo_bought)
	file.store_var(is_sky_bought)
	
	#BACKGROUNDS
	file.store_var(is_space_background_bought)
	file.store_var(is_vaporwave_background_bought)
	file.store_var(is_fantasy_background_bought)
	
	#BALL EFFECTS
	
	file.close()

func load_unlockables_data() -> void:
	if FileAccess.file_exists(unlockables_save_path):
		var file = FileAccess.open(unlockables_save_path, FileAccess.READ)
		
		coins = file.get_var(coins)
		
		#MUSIC
		is_cyberpunk_bought = file.get_var(is_cyberpunk_bought)
		is_arcade_bought = file.get_var(is_arcade_bought)
		is_hero_immortal_bought = file.get_var(is_hero_immortal_bought)
		is_lunar_echo_bought = file.get_var(is_lunar_echo_bought)
		is_sky_bought = file.get_var(is_sky_bought)
		
		#BACKGROUNDS
		is_space_background_bought = file.get_var(is_space_background_bought)
		is_vaporwave_background_bought = file.get_var(is_vaporwave_background_bought)
		is_fantasy_background_bought = file.get_var(is_fantasy_background_bought)
		
		#BALL EFFECTS
		
		file.close()
	else:
		coins = 0
		
		#MUSIC
		is_cyberpunk_bought = false
		is_arcade_bought = false
		is_hero_immortal_bought = false
		is_lunar_echo_bought = false
		is_sky_bought = false
		
		#BACKGROUNDS
		is_space_background_bought = false
		is_vaporwave_background_bought = false
		is_fantasy_background_bought = false
		
		#BALL EFFECTS


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
	is_game_over = false
	get_tree().paused = false
	$HUD.hide()
	$HUD/GameOver.hide()
	lives = 6
	points = 0
	number_of_repeats = 0
	points_label.text = "SCORE: " + str(points)
	lives_label.text = "LIVES: " + str(lives)


func _on_change_level_timer_timeout() -> void:
	number_of_broken_blocks = max_number_of_blocks
	increase_block_counter()
	
