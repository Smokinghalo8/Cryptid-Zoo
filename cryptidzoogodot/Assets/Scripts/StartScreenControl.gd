extends Control


func _on_game_start_button_pressed() -> void: #Start
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().change_scene_to_file("res://Scenes/city.tscn")
	#when the game start button is pressed change the scene
	pass # Replace with function body.


func _on_game_options_button_pressed() -> void: #Options
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().change_scene_to_file("res://Scenes/SettingsScreen.tscn")
	pass # Replace with function body.


func _on_game_exit_button_pressed() -> void: #Exit
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().quit()
	pass # Replace with function body.
