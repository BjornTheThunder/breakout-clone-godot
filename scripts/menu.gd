extends Control

func _ready() -> void:
	$Settings/MarginContainer/VBoxContainer/VolumeSlider.value = AudioServer.get_bus_volume_db(1)
	$Settings/MarginContainer/VBoxContainer/MusicVolumeSlider.value = AudioServer.get_bus_volume_db(2)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_endless_mode_pressed() -> void:
	GameManager.play_click_gui_sound()
	get_tree().change_scene_to_file("res://scenes/levels/endless_mode.tscn")


func _on_options_pressed() -> void:
	$MainMenu.hide()
	$Settings.show()


func _on_main_menu_button_pressed() -> void:
	$Settings.hide()
	$MainMenu.show()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)


func _on_resolution_selector_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(320, 240))
		1:
			DisplayServer.window_set_size(Vector2i(640, 480))
		2:
			DisplayServer.window_set_size(Vector2i(960, 720))
		3:
			DisplayServer.window_set_size(Vector2i(1280, 960))
		4:
			DisplayServer.window_set_size(Vector2i(1600, 1200))


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		_on_resolution_selector_item_selected($Settings/MarginContainer/VBoxContainer/ResolutionSelector.get_index())
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	GameManager.play_click_gui_sound()

#unlockables return-back button
func _on_back_button_pressed() -> void:
	$Unlockables.hide()
	$MainMenu.show()

func _on_unlockables_pressed() -> void:
	$MainMenu.hide()
	$Unlockables.show()

func _on_music_theme_button_pressed() -> void:
	$Unlockables/TypeSelection.hide()
	$Unlockables/MusicThemes.show()


func _on_background_theme_button_pressed() -> void:
	$Unlockables/TypeSelection.hide()
	$Unlockables/BackgroundThemes.show()


func _on_ball_theme_button_pressed() -> void:
	$Unlockables/BallThemes.show()
	$Unlockables/TypeSelection.hide()


func _on_credits_back_button_pressed() -> void:
	$Credits.hide()
	$MainMenu.show()


func _on_credits_pressed() -> void:
	$MainMenu.hide()
	$Credits.show()
