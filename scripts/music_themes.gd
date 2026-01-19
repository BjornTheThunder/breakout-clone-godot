extends Control

@onready var title_music = $"../../TitleTheme"
@onready var ingame_music = $Ingame
@onready var cyberpunk_music = $CyberpunkArcade
@onready var arcade_music = $Arcade
@onready var hero_immortal_music = $HeroImmortal
@onready var lunar_echo_music =$LunarEcho
@onready var sky_music = $ThisSkyeOfMine

func _ready() -> void:
	if GameManager.is_cyberpunk_bought:
		$HBoxContainer/VBoxContainer/CyberpunkArcade2/Button.disabled = false
		$HBoxContainer/VBoxContainer/CyberpunkArcade2/BuyCyberpunk.disabled = true
	if GameManager.is_arcade_bought:
		$HBoxContainer/VBoxContainer/Arcade2/Button.disabled = false
		$HBoxContainer/VBoxContainer/Arcade2/BuyArcade.disabled = true
	if GameManager.is_hero_immortal_bought:
		$HBoxContainer/VBoxContainer2/HeroImmortal2/Button.disabled = false
		$HBoxContainer/VBoxContainer2/HeroImmortal2/BuyHeroImmortal.disabled = true
	if GameManager.is_lunar_echo_bought:
		$HBoxContainer/VBoxContainer2/LunarEcho2/Button.disabled = false
		$HBoxContainer/VBoxContainer2/LunarEcho2/BuyLunarEcho.disabled = true
	if GameManager.is_sky_bought:
		$HBoxContainer/VBoxContainer2/MySky2/Button.disabled = false
		$HBoxContainer/VBoxContainer2/MySky2/BuySky.disabled = true
	
	$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)

func play_title() -> void:
	GameManager.change_song("res://music/ctr_title.mp3")
	title_music.play()
	ingame_music.stop()
	cyberpunk_music.stop()
	arcade_music.stop()
	hero_immortal_music.stop()
	lunar_echo_music.stop()
	sky_music.stop()

func play_ingame() -> void:
	GameManager.change_song("res://music/ctr_ingame.mp3")
	title_music.stop()
	ingame_music.play()
	cyberpunk_music.stop()
	arcade_music.stop()
	hero_immortal_music.stop()
	lunar_echo_music.stop()
	sky_music.stop()


func play_cyberpunk() -> void:
	GameManager.change_song("res://music/cyberpunk_arcade_3.mp3")
	title_music.stop()
	ingame_music.stop()
	cyberpunk_music.play()
	arcade_music.stop()
	hero_immortal_music.stop()
	lunar_echo_music.stop()
	sky_music.stop()


func play_arcade() -> void:
	GameManager.change_song("res://music/Arcade.mp3")
	title_music.stop()
	ingame_music.stop()
	cyberpunk_music.stop()
	arcade_music.play()
	hero_immortal_music.stop()
	lunar_echo_music.stop()
	sky_music.stop()


func play_hero_immortal() -> void:
	GameManager.change_song("res://music/Hero Immortal.mp3")
	title_music.stop()
	ingame_music.stop()
	cyberpunk_music.stop()
	arcade_music.stop()
	hero_immortal_music.play()
	lunar_echo_music.stop()
	sky_music.stop()


func play_lunar_echo() -> void:
	GameManager.change_song("res://music/lunar_echo.mp3")
	title_music.stop()
	ingame_music.stop()
	cyberpunk_music.stop()
	arcade_music.stop()
	hero_immortal_music.stop()
	lunar_echo_music.play()
	sky_music.stop()


func play_sky() -> void:
	GameManager.change_song("res://music/This Sky of Mine.mp3")
	title_music.stop()
	ingame_music.stop()
	cyberpunk_music.stop()
	arcade_music.stop()
	hero_immortal_music.stop()
	lunar_echo_music.stop()
	sky_music.play()


func _on_back_button_pressed() -> void:
	hide()
	$"../TypeSelection".show()


func _on_buy_cyberpunk_pressed() -> void:
	if GameManager.coins >= 50:
		$"../../PurchaseSound".play()
		GameManager.coins -= 50
		GameManager.is_cyberpunk_bought = true
		GameManager.save_unlockables_data()
		$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)
		$HBoxContainer/VBoxContainer/CyberpunkArcade2/Button.disabled = false
		$HBoxContainer/VBoxContainer/CyberpunkArcade2/BuyCyberpunk.disabled = true
	else:
		$"../../WrongSound".play()


func _on_buy_arcade_pressed() -> void:
	if GameManager.coins >= 100:
		$"../../PurchaseSound".play()
		GameManager.coins -= 100
		GameManager.is_arcade_bought = true
		GameManager.save_unlockables_data()
		$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)
		$HBoxContainer/VBoxContainer/Arcade2/Button.disabled = false
		$HBoxContainer/VBoxContainer/Arcade2/BuyArcade.disabled = true
	else:
		$"../../WrongSound".play()


func _on_buy_hero_immortal_pressed() -> void:
	if GameManager.coins >= 100:
		$"../../PurchaseSound".play()
		GameManager.coins -= 100
		GameManager.is_hero_immortal_bought = true
		GameManager.save_unlockables_data()
		$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)
		$HBoxContainer/VBoxContainer2/HeroImmortal2/Button.disabled = false
		$HBoxContainer/VBoxContainer2/HeroImmortal2/BuyHeroImmortal.disabled = true
	else:
		$"../../WrongSound".play()


func _on_buy_lunar_echo_pressed() -> void:
	if GameManager.coins >= 150:
		$"../../PurchaseSound".play()
		GameManager.coins -= 150
		GameManager.is_lunar_echo_bought = true
		GameManager.save_unlockables_data()
		$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)
		$HBoxContainer/VBoxContainer2/LunarEcho2/Button.disabled = false
		$HBoxContainer/VBoxContainer2/LunarEcho2/BuyLunarEcho.disabled = true
	else:
		$"../../WrongSound".play()

func _on_buy_sky_pressed() -> void:
	if GameManager.coins >= 200:
		$"../../PurchaseSound".play()
		GameManager.coins -= 200
		GameManager.is_sky_bought = true
		GameManager.save_unlockables_data()
		$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)
		$HBoxContainer/VBoxContainer2/MySky2/Button.disabled = false
		$HBoxContainer/VBoxContainer2/MySky2/BuySky.disabled = true
	else:
		$"../../WrongSound".play()
