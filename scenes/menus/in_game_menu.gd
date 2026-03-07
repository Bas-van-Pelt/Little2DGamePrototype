extends Control

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("open_menu"):
		toggle_pause()

func toggle_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	if new_pause_state:
		$CenterContainer/Buttons/Resume.grab_focus()
	else:
		hide()

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_settings_pressed() -> void:
	print("Instellingen geopend")

func _on_exit_pressed() -> void:
	get_tree().quit()
