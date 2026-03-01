extends Node2D

# Both of these are not used for now
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	$CenterContainer/SettingsMenu/Fullscreen.button_pressed = true
	$CenterContainer/Buttons/Play.grab_focus()
	$CenterContainer/SettingsMenu/MainVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$CenterContainer/SettingsMenu/MusicVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("MUSIC")))
	$CenterContainer/SettingsMenu/SFXVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	#for my dumbah... (i keep forgetting to hide these nodes
	$CenterContainer/SettingsMenu.visible = false
	$CenterContainer/CreditsMenu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
#	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/core/HomeScene.tscn")

func _on_settings_pressed() -> void:
	$CenterContainer/Buttons.visible = false
	$CenterContainer/SettingsMenu.visible = true
	$CenterContainer/SettingsMenu/Fullscreen.grab_focus()

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_main_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_music_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"), value)

func _on_sfx_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)

func _on_credits_pressed() -> void:
	$CenterContainer/Buttons.visible = false
	$CenterContainer/CreditsMenu.visible = true
	$CenterContainer/CreditsMenu/Back.grab_focus()
	
func _on_back_pressed() -> void:
	$CenterContainer/Buttons.visible = true
	if $CenterContainer/SettingsMenu.visible:
		$CenterContainer/SettingsMenu.visible = false
		$CenterContainer/Buttons/Settings.grab_focus()
	elif $CenterContainer/CreditsMenu.visible:
		$CenterContainer/CreditsMenu.visible = false
		$CenterContainer/Buttons/Credits.grab_focus()
	else:
		$CenterContainer/Buttons/Play.grab_focus()

func _on_exit_pressed() -> void:
	get_tree().quit()
