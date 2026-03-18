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
	if body.is_in_group("Character"):
		if Global.gnomeState == 3:
			print("THIS IS WHERE THE END SHOULD GO!")
		elif Global.gnomeState == 2:
			#back from scav hunt
			#TODO work from here, coded in everything prior
			Global.playerShouldBeMoving = false
			await DialogueManager.show_dialogue_balloon(dialogue, "backToKingAfterScavenger").finished
			Global.playerShouldBeMoving = true
			Global.gnomeState = 50 #WERE IN THE 50s NOW BABY WOOO
			print(Global.gnomeState)
			#check the DogHedge object inside the maze now!
			#inside gnome_map.gd this immeditally becomes gnomestate = 51, to break out of a loop
			
		elif Global.gnomeState == 1:
			#back from mushrooms
			Global.playerShouldBeMoving = false
			await DialogueManager.show_dialogue_balloon(dialogue, "backToKingAfterShrooms").finished
			Global.playerShouldBeMoving = true
			Global.gnomeState = 10#go to Bleafus
			
		elif Global.gnomeState == 0:
			#play dialogue from gnome king at start, after getting teleported to him
			Global.playerShouldBeMoving = false
			await DialogueManager.show_dialogue_balloon(dialogue, "teleportToGnomeKing").finished
			Global.playerShouldBeMoving = true
			Global.gnomeState = 13 #make this number a number to make the player able to talk to Bloogargth
