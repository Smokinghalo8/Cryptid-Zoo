extends TextureButton


func _on_pressed() -> void:
	$ButtonPressNoise.play(0)
	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().change_scene_to_file("uid://ccfke0dy4rixg")
