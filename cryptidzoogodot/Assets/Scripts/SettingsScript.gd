extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_db = AudioServer.get_bus_volume_db(GlobalSettings.master_bus)
	var linear_val = db_to_linear(current_db)
	$VolumeSlider.set_value_no_signal(linear_val)

func _on_volume_slider_value_changed(value: float) -> void:
	GlobalSettings.set_volume(value)

func _on_back_button_pressed() -> void:
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().change_scene_to_file("uid://ccfke0dy4rixg")
