extends Control

func _ready():
	hide()
	$CenterContainer/MenuButtons.visible = true
	$CenterContainer/SettingsMenuSelection.visible = false

func _input(event):
	if event.is_action_pressed("open_menu"):
		toggle_pause()

func toggle_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	if new_pause_state:
		$CenterContainer/MenuButtons/Resume.grab_focus()
	else:
		hide()

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_settings_pressed() -> void:
	$CenterContainer/SettingsMenuSelection.visible = true
	$CenterContainer/MenuButtons.visible = false
	$CenterContainer/SettingsMenuSelection/Back.grab_focus()

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/MainMenu.tscn")
	#get_tree().quit()
# =====================================
# =========== settings menu ===========
# =====================================
func _on_back_pressed() -> void:
	$CenterContainer/SettingsMenuSelection.visible = false
	$CenterContainer/MenuButtons.visible = true
	$CenterContainer/MenuButtons/Resume.grab_focus()

func _on_audio_settings_pressed() -> void:
	print("audio settings pressed")

func _on_video_settings_pressed() -> void:
	print("video settings pressed")

func _on_control_settings_pressed() -> void:
	print("control settings pressed")
