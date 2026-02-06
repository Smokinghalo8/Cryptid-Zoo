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
	#highest going down
	if Global.gnomeState == 3:
		#back from maze
		#end game scene, which isnt made yet- sorry
		pass
	elif Global.gnomeState == 2:
		#back from scav hunt
		#TODO work from here, coded in everything prior
		await DialogueManager.show_dialogue_balloon(dialogue, "backToKingAfterScavenger").finished
		Global.gnomeState = 50 #WERE IN THE 50s NOW BABY WOOO
		pass
	elif Global.gnomeState == 1:
		#back from mushrooms
		await DialogueManager.show_dialogue_balloon(dialogue, "backToKingAfterShrooms").finished
		Global.gnomeState = 10
		pass
	elif Global.gnomeState == 0:
		#play dialogue from gnome king at start, after getting teleported to him
		await DialogueManager.show_dialogue_balloon(dialogue, "teleportToGnomeKing").finished
		Global.gnomeState = 13 #make this number a number to make the player able to talk to Bloogargth
	pass # Replace with function body.
