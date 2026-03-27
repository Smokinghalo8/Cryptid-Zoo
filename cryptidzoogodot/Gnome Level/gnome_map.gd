extends Node3D

#TODO Implement interact for Zed character, how did Tyler do this with Raycasts in the other levels?
var MushroomQuest = false
var ScavQuest = false
var mazeQuest = false
@onready var quest_hedge: Node3D = $quest_hedge
@onready var bloogaragth: StaticBody3D = $bloogaragth
@onready var bleafus_the_gnome: StaticBody3D = $Bleafus_the_gnome
@onready var THE_KING: StaticBody3D = $GnomeKING
@onready var playerZed = $Z


func _ready() -> void:
	Global.mothmanPower = true
	bloogaragth.visible = true
	#TODO Apply new idea below!
	#unless we tp the player to the KING which i think we should, we have to set visability on bleafus to false too
	pass
	

func _process(delta: float) -> void:
	#TODO Create if statements to check if all the levelQuest booleans are true WHEN the player interacts with GnomeKing
	checkAndApplyGlobals()


	#if MushroomQuest and ScavQuest and mazeQuest:
		#Global.gnomeState = 4 #set the GnomeKing to talk about how cool you are or smthn
	#elif MushroomQuest and ScavQuest:
		#Global.gnomeState = 3 # meaning GnomeKing talks about the MazeQuest
		##opens up Hedge!
		
	#elif MushroomQuest:
		#bloogaragth.visible = true #on the offchance the player is feelin explorative
		#Global.gnomeState = 2 #Give you ScavQuest
		#print(str(Global.gnomeState))
	
	
	
	#processQuitButton
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		togglePause()
	
	
	
func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true
	
func checkAndApplyGlobals():
	#CHECK THINGSGATHERED
	
	if Global.thingsGathered == 2 and Global.convoDone:
		
		ScavQuest = true;
		print("scav quest is true")
		Global.thingsGathered = 0
		Global.convoDone = false
		
	elif Global.thingsGathered == 2:
		Global.gnomeState = 41
		#print(Global.gnomeState) getting 41
	
	
	#CHECK SHROOMS ATE
	if Global.shroomsAte == 2:
		MushroomQuest = true
		print("Mushroom quest is true")
		Global.shroomsAte = 0
		
	if ScavQuest == true and MushroomQuest == true and Global.HedgeCompleted == true:
		Global.gnomeState = 3
		#HOPEFULLY last line from GnomeKing
	elif ScavQuest == true and MushroomQuest == true:
		Global.gnomeState = 2
		#this being here means I cant go back to bleafus and finish our convo also need to get rid of extra hedge
		
		
		
		
	if Global.gnomeState == 50:
		quest_hedge.global_position = Vector3(0,0,-10)
		quest_hedge.visible = false
		quest_hedge.queue_free()
		Global.gnomeState = 51
		

	
	
	
