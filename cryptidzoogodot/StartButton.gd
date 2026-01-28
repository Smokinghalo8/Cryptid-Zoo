extends TextureButton


func _on_pressed() -> void:
#	$ButtonPressNoise.play(0)
#	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().change_scene_to_file("uid://bf4vgu7u0t3ri")
	#when the game start button is pressed change the scene
	pass
