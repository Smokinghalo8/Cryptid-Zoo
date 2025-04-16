extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_start_button_pressed() -> void: #Start
	get_tree().change_scene_to_file("res://Scenes/city.tscn")
	#when the game start button is pressed change the scene
	pass # Replace with function body.


func _on_game_options_button_pressed() -> void: #Options
	get_tree().change_scene_to_file("res://Scenes/SettingsScreen.tscn")
	pass # Replace with function body.


func _on_game_exit_button_pressed() -> void: #Exit
	get_tree().quit()
	pass # Replace with function body.
