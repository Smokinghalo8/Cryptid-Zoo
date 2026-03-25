extends Node3D

#TODO Implement interact for Zed character, how did Tyler do this with Raycasts in the other levels?
var MushroomQuest = false
var ScavQuest = false
var mazeQuest = false
var isAnimationDone = false
@onready var quest_hedge: Node3D = $quest_hedge
@onready var bloogaragth: StaticBody3D = $bloogaragth
@onready var bleafus_the_gnome: StaticBody3D = $Bleafus_the_gnome
@onready var THE_KING: StaticBody3D = $GnomeKING
@onready var playerZed = $Z
@onready var playerZedCamera = $Z/Head
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Cam1: Camera3D = $OverView1
@onready var Cam2: Camera3D = $OverView2
@onready var Cam3: Camera3D = $OverView3
@onready var Cam4: Camera3D = $OverView4
@onready var MothmanModel: Node3D = $Mothman_GEO


@export var dialogue : DialogueResource
var dialogueLines 




func _ready() -> void:
	bloogaragth.visible = true
	#TODO fix player being able to move during this cut scene?

	await toggleAnimation(1)
	await toggleAnimation(2)
	#skip 3, not done yet
	await toggleAnimation(4)
	await toggleAnimation(5)
	playerZed.position = Vector3(145, 5, 40)#edit, might need to make a 1 or something Y value, that is
	playerZed.rotation = Vector3(0,0,0)
	playerZed.set_process_input(true)

	playerZedCamera.make_current()
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
	
	
func toggleAnimation(animationNumber) -> int:
	var animationNum = animationNumber
	if(animationNum == 1):
		playerZed.set_process_input(false)
		#switchToFirstAniamtion
		#andtoggleCamera
		Cam1.make_current()
		animation_player.play("MothmanBringingZedToGnomeLevel")
		#await animation_player.animation_finished#USE THIS KEYWORD
		await DialogueManager.show_dialogue_balloon(dialogue, "introTalkWithMothman").finished
		#create an await function and wait out Zeds conversation with Mothman
		#TODO after creating the second animation, set it to play RIGHT after this animation plays
		#toggleAnimation(2)
	elif(animationNum == 2):
		playerZed.set_process_input(false)

		#todo finish
		Cam2.make_current()
		animation_player.play("BulletHittingZedAndMothman")
		await animation_player.animation_finished
		#toggleAnimation(3)
		#after this animation, add an animation of an explosion that happens where Mothman and Zed were
	elif(animationNum == 3):
		playerZed.set_process_input(false)
		#in this one create explosion animaion, skipping for now
		toggleAnimation(4)
		pass
	elif(animationNum == 4):
		playerZed.set_process_input(false)
		#Make Zed falling animation play
		Cam3.make_current()
		animation_player.play("ZedFalling")
		await animation_player.animation_finished
		#toggleAnimation(5)
	elif(animationNum == 5):
		playerZed.set_process_input(false)
		#play camera pulling up into the sky after Zed falls animaion
		Cam4.make_current()
		animation_player.play("CameraFloatingAroundZedBeforeAwaking")
		MothmanModel.visible = false
		await animation_player.animation_finished
		pass
	return 3
	
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
		

	
	
	
