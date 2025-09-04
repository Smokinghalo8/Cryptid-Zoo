extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VolumeSlider.value))

func _on_back_button_pressed() -> void:
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().paused = false
	$".".visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_main_menu_pressed() -> void:
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/PreGameScene.tscn")
