extends Control


func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VolumeSlider.value))

func _on_main_menu_button_pressed() -> void:
	print("Worked");
	$ButtonPressNoise.play(0)
	#await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().paused = false
	get_tree().change_scene_to_file("uid://ccfke0dy4rixg")


func _on_resume_button_pressed() -> void:
	$ButtonPressNoise.play(0)
	#await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().paused = false
	$".".visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_button_pressed() -> void:
	print("grerbfubeup")


func _on_main_menu_button_button_down() -> void:
	print("grerbfubeup")
