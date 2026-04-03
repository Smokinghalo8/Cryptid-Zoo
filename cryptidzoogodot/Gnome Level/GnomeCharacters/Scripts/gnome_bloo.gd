extends StaticBody3D


@export var dialogue : DialogueResource
var dialogueLines 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		if Global.gnomeState == 13:
			#play init talk
			await DialogueManager.show_dialogue_balloon(dialogue, "rouletteGnomeGiveQuest").finished
			Global.gnomeState = 20
			#now go to shroom 1 & 2.gd to find when gnomestate == 21
			
		elif Global.gnomeState == 21:
			#quest done
			await DialogueManager.show_dialogue_balloon(dialogue, "rouletteGnomeEndQuest").finished
			Global.gnomeState = 1 #now player can go back to Gnome King
			
			pass
		elif Global.gnomeState == 22:
			#failState
			await DialogueManager.show_dialogue_balloon(dialogue, "rouletteGnomeEndQuestFail").finished
			Global.gnomeState = 99 #whatever to get rid of dialogue
		pass # Replace with function body.
