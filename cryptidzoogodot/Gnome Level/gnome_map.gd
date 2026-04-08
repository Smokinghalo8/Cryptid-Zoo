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
@onready var tinyBullet: StaticBody3D = $TinyBullet
@onready var explostion: Sprite3D = $ExplosionGif
@onready var ENTIRE_UI_LAYER: CanvasLayer = $Ui
@onready var sprintBar: TextureProgressBar = $Ui/SprintBar
@onready var FunniFlowerNode: Node3D = $"HTerrain/@Node3D@75207"



@onready var playerZedCamera = $Z/Head
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Cam1: Camera3D = $OverView1
@onready var Cam2: Camera3D = $OverView2
@onready var Cam3: Camera3D = $OverView3
@onready var Cam4: Camera3D = $OverView4
@onready var Cam5: Camera3D = $OverView5
@onready var Cam6: Camera3D = $OverView6
@onready var Cam7: Camera3D = $OverView7
@onready var Cam8: Camera3D = $OverView8



@onready var TwinOfTheUnnamed: StaticBody3D = $TwinOfTheUnnamedOne
@onready var MothmanModel: Node3D = $Mothman_GEO


@export var dialogue : DialogueResource
var dialogueLines 




func _ready() -> void:
	$Ui.visible = false
	Global.mothmanPower = true
	bloogaragth.visible = true
	explostion.visible = false
	#TODO movew this into the Shrooms scene, so we can enable these guys visabilty and enable/disable them for being high on shrroms
	#FunniFlowerNode.visible = false
	#TODO fix player being able to move during this cut scene? - is this still an issue??
	playerZed.turnOnHead()
	
	await toggleAnimation(1)
	await toggleAnimation(2)

	await toggleAnimation(3)
	await toggleAnimation(4)
	await toggleAnimation(5)
	await toggleAnimation(6)
	await toggleAnimation(7)
	playerZed.position = Vector3(145, 5, 40)#edit, might need to make a 1 or something Y value, that is
	playerZed.rotation = Vector3(0,0,0)
	playerZed.scale = Vector3(1.0,1.0,1.0)
	playerZed.set_process_input(true)
	
	playerZed.turnOffHead()
	playerZedCamera.make_current()
	$Ui.visible = true
	#TODO Apply new idea below!
	#unless we tp the player to the KING which i think we should, we have to set visability on bleafus to false too
	pass
	

func _process(delta: float) -> void:
	#TODO Create if statements to check if all the levelQuest booleans are true WHEN the player interacts with GnomeKing
	checkAndApplyGlobals()
	
	$Ui/SprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false


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
		sprintBar.visible = false
		#switchToFirstAniamtion
		#andtoggleCamera
		Cam1.make_current()
		animation_player.play("MothmanBringingZedToGnomeLevel")
		#await animation_player.animation_finished#USE THIS KEYWORD
		DialogueManager.show_dialogue_balloon(dialogue, "introTalkWithMothman").finished
		await animation_player.animation_finished
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
		
		#use Cam7 for this one
		Cam7.make_current()
		animation_player.play("ZedAndMothmanEXPLODE")
		await animation_player.animation_finished
		MothmanModel.visible = false
		tinyBullet.visible = false
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
		await animation_player.animation_finished
	elif(animationNum == 6):
		#camera on Zed landing on Gnome
		Cam5.make_current()
		animation_player.play("ZedLandingOnGnomeCloseup")
		await animation_player.animation_finished
	elif(animationNum == 7):
		#camera on Zed shrinking
		TwinOfTheUnnamed.visible = false
		Cam6.make_current()
		animation_player.play("ZedShrinking")
		await animation_player.animation_finished
	elif(animationNum == 8):
		#This should be end game cutscene when GnomeKing grows Zed
		Cam8.make_current()
		animation_player.play("GnomeKingGrowsZed")
		await DialogueManager.show_dialogue_balloon(dialogue, "mazeGnomeEndScene1").finished
		
		#at the very very end, give the UI back
		sprintBar.visible = true
	elif(animationNum ==9):
		#Cutscene where Mothman found Zed and comes to pick him and Gnome King up
		Cam8.make_current()
		animation_player.play("GnomeKingThanksZedAndMothmanShowsUp")
		await DialogueManager.show_dialogue_balloon(dialogue, "mazeGnomeEndScene2").finished

		pass
		
	return 3
	
func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true
	
	
func toggleUIVisabiliy():
	#fix to enable escape button
	if ENTIRE_UI_LAYER.visible==true:
		ENTIRE_UI_LAYER.visible=false
	elif ENTIRE_UI_LAYER.visible==false:
		ENTIRE_UI_LAYER.visible=true
	
	
	
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
		

	
	
	
