extends StaticBody3D

@export var dialogue_resource: DialogueResource

func interact():
	#$"../Ui/Dialog".CityNotes1()
	DialogueManager.show_dialogue_balloon(dialogue_resource, "Note1")
