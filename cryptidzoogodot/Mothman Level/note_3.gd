extends StaticBody3D

#@export var dialogue_resource: DialogueResource
#
#func interact():
	#DialogueManager.show_dialogue_balloon(dialogue_resource, "Note3")

func interact():
	$"../Ui/Newspapers/NpMothman3".visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	#insert dialogue here

func _on_np_mothman_3_button_pressed() -> void:
	get_tree().paused = false
	$"../Ui/Newspapers/NpMothman3".visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
