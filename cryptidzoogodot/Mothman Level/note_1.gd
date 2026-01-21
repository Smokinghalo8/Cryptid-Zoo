extends StaticBody3D

#@export var dialogue_resource: DialogueResource
#
#func interact():
	#DialogueManager.show_dialogue_balloon(dialogue_resource, "Note1")

var original_pos: Vector3
var original_rot: Vector3
var is_inspecting: bool = false

func interact():
	$"../Ui/Newspapers/NpMothman1".visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	#insert dialogue here
	

func _on_button_pressed() -> void:
	get_tree().paused = false
	$"../Ui/Newspapers/NpMothman1".visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
