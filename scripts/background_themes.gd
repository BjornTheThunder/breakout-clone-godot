extends Control


func _ready() -> void:
	$MarginContainer/MarginContainer/CoinLabel.text = "COINS: " + str(GameManager.coins)
	
	if GameManager.is_space_background_bought:
		$VBoxContainer/HBoxContainer2/SpaceSet.disabled = false
		$VBoxContainer/HBoxContainer2/BuySpace.disabled = true
	if GameManager.is_vaporwave_background_bought:
		$VBoxContainer/HBoxContainer3/VaporwaveSet.disabled = false
		$VBoxContainer/HBoxContainer3/BuyVaporwave.disabled = true
	if GameManager.is_fantasy_background_bought:
		$VBoxContainer/HBoxContainer4/FantasySet.disabled = false
		$VBoxContainer/HBoxContainer4/BuyFantasy.disabled = true

func _on_back_button_pressed() -> void:
	hide()
	$"../TypeSelection".show()


func _on_castel_set_pressed() -> void:
	$Background.show()
	$Space.hide()
	$Vaporwave.hide()
	$FantasyTileset.hide()
	GameManager.background_type = "base"


func _on_space_set_pressed() -> void:
	$Background.hide()
	$Space.show()
	$Vaporwave.hide()
	$FantasyTileset.hide()
	GameManager.background_type = "space"


func _on_vaporwave_set_pressed() -> void:
	$Background.hide()
	$Space.hide()
	$Vaporwave.show()
	$FantasyTileset.hide()
	GameManager.background_type = "vaporwave"


func _on_fantasy_set_pressed() -> void:
	$Background.hide()
	$Space.hide()
	$Vaporwave.hide()
	$FantasyTileset.show()
	GameManager.background_type = "fantasy"


func _on_buy_space_pressed() -> void:
	if GameManager.coins >= 100:
		$"../../PurchaseSound".play()
		GameManager.coins -= 100
		GameManager.is_space_background_bought = true
		GameManager.save_unlockables_data()
		$VBoxContainer/HBoxContainer2/SpaceSet.disabled = false
		$VBoxContainer/HBoxContainer2/BuySpace.disabled = true
	else:
		$"../../WrongSound".play()


func _on_buy_vaporwave_pressed() -> void:
	if GameManager.coins >= 150:
		$"../../PurchaseSound".play()
		GameManager.coins -= 150
		GameManager.is_vaporwave_background_bought = true
		GameManager.save_unlockables_data()
		$VBoxContainer/HBoxContainer3/VaporwaveSet.disabled = false
		$VBoxContainer/HBoxContainer3/BuyVaporwave.disabled = true
	else:
		$"../../WrongSound".play()


func _on_buy_fantasy_pressed() -> void:
	if GameManager.coins >= 200:
		$"../../PurchaseSound".play()
		GameManager.coins -= 200
		GameManager.is_fantasy_background_bought = true
		GameManager.save_unlockables_data()
		$VBoxContainer/HBoxContainer4/FantasySet.disabled = false
		$VBoxContainer/HBoxContainer4/BuyFantasy.disabled = true
	else:
		$"../../WrongSound".play()
