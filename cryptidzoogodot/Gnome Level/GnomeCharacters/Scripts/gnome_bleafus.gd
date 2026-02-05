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
	#when player goes into Bleafus body to say smthn
	#bleafus gives player Scav hunt quest, should be the second quest
	#should be 4 states, after quest is done (11?)
	# 10=First talk - GnomeKing setup
	# 2=End Quest
	# 1= Before anything, debug - shouldnt be possible
	if Global.gnomeState == 11:
		pass 
	elif Global.gnomeState == 10:
		await DialogueManager.show_dialogue_balloon(dialogue, "fetchGnomeGiveQuest").finished
		Global.gnomeState = 12
		#set gnomstate to 2 after picked up everything
		pass
	elif Global.gnomeState == 2:
		await DialogueManager.show_dialogue_balloon(dialogue, "fetchGnomeEndQuest").finished
		Global.gnomeState = 2
		pass
	elif Global.gnomeState == 1:
		#TODO put some bs here
		pass
	
	pass # Replace with function body.
