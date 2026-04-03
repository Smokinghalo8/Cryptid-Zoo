extends StaticBody3D

#@export var dialogue_resource: DialogueResource
#
#func interact():
	#DialogueManager.show_dialogue_balloon(dialogue_resource, "Note4")

func interact():
	$"../Ui/Newspapers/NpMothman4".visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	#insert dialogue here

func _on_np_mothman_4_button_pressed() -> void:
	get_tree().paused = false
	$"../Ui/Newspapers/NpMothman4".visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
