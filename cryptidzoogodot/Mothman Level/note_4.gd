extends StaticBody3D

@export var dialogue_resource: DialogueResource

func interact():
	DialogueManager.show_dialogue_balloon(dialogue_resource, "Note4")
