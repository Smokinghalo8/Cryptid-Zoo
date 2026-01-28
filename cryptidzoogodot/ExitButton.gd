extends TextureButton


func _on_pressed() -> void:
#	$ButtonPressNoise.play(0)
#	await get_tree().create_timer($ButtonPressNoise.stream.get_length())
	get_tree().quit()
	pass # Replace with function body.
