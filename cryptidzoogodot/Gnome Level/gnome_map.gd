extends Node3D

#TODO Implement interact for Zed character, how did Tyler do this with Raycasts in the other levels?
var MushroomQuest = false
var ScavQuest = false
var mazeQuest = false


func _ready() -> void:
	

	
	pass
	

func _process(delta: float) -> void:
	#TODO Create if statements to check if all the levelQuest booleans are true WHEN the player interacts with GnomeKing
	if MushroomQuest and ScavQuest and mazeQuest:
		Global.gnomeState = 4 #set the GnomeKing to talk about how cool you are or smthn
	elif MushroomQuest and ScavQuest:
		Global.gnomeState = 3 # meaning GnomeKing talks about the MazeQuest
	elif MushroomQuest:
		Global.gnomeState = 2 #Give you ScavQuest
	pass
	
