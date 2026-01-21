extends StaticBody3D

#@export var dialogue_resource: DialogueResource
#
#func interact():
	#DialogueManager.show_dialogue_balloon(dialogue_resource, "Note2")

func interact():
	$"../Ui/Newspapers/NpMothman2".visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	#insert dialogue here

func _on_np_mothman_2_button_pressed() -> void:
	get_tree().paused = false
	$"../Ui/Newspapers/NpMothman2".visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
