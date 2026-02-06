extends Node3D

#TODO Implement interact for Zed character, how did Tyler do this with Raycasts in the other levels?
var MushroomQuest = false
var ScavQuest = false
var mazeQuest = false
@onready var quest_hedge: Node3D = $quest_hedge
@onready var bloogaragth: StaticBody3D = $bloogaragth
@onready var bleafus_the_gnome: StaticBody3D = $Bleafus_the_gnome
@onready var THE_KING: StaticBody3D = $GnomeKING


func _ready() -> void:
	bloogaragth.visible = false
	#unless we tp the player to the KING which i think we should, we have to set visability on bleafus to false too
	pass
	

func _process(delta: float) -> void:
	#TODO Create if statements to check if all the levelQuest booleans are true WHEN the player interacts with GnomeKing
	if MushroomQuest and ScavQuest and mazeQuest:
		Global.gnomeState = 4 #set the GnomeKing to talk about how cool you are or smthn
	elif MushroomQuest and ScavQuest:
		Global.gnomeState = 3 # meaning GnomeKing talks about the MazeQuest
		quest_hedge.queue_free() #wow get open access now :
	elif MushroomQuest:
		bloogaragth.visible = true #on the offchance the player is feelin explorative
		Global.gnomeState = 2 #Give you ScavQuest
	
	#CHECK THINGSGATHERED
	if Global.thingsGathered == 2:
		ScavQuest = true;
		Global.thingsGathered = 0
	
	
	#CHECK SHROOMS ATE
	if Global.shroomsAte == 2:
		MushroomQuest = true
	
	pass
	
	
	
