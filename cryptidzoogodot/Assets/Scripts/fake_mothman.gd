extends RigidBody3D


var wingMat = preload("uid://c3bmtkx415kd7")
var bodyMat = preload("uid://choyex4eym2uc")
var furMat = preload("uid://bupl7ucm0q2rd")
var ffMat = preload("uid://bx13i1os11ky8")
var naturalMat = preload("uid://c24ja6ql5sqp7");
var highlightMat = preload("uid://diycl1rchl5ww")
@onready var animPlayer = get_node("/root/" + get_tree().current_scene.name + "/MothmanAnims")
@onready var skybeam = $Skybeam
@export var dialogue_resource: DialogueResource

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	$MothmanNew/AnimationPlayer.play("idle")
	$MothManNoises.play(0)
	$MothmanNew/metarig/Skeleton3D/Bone/Mothman_Lower_Wing_GEO_001.set_surface_override_material(0, wingMat)
	$MothmanNew/metarig/Skeleton3D/Bone/Mothman_Lower_Wing_GEO_002.set_surface_override_material(0, wingMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Antenna_GEO.set_surface_override_material(0, ffMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Arm_GEO.set_surface_override_material(0, bodyMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Eye_GEO.set_surface_override_material(0, ffMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_01_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_02_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_03_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_04_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_05_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_06_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_07_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_08_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_08_GEO1.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Head_GEO.set_surface_override_material(0, bodyMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Leg_GEO.set_surface_override_material(0, bodyMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Upper_Wing_GEO_001.set_surface_override_material(0, wingMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Upper_Wing_GEO_002.set_surface_override_material(0, wingMat)
	

func _process(delta: float) -> void:
	if Global.animNum <= 1.0:
		$Big.monitoring = false
		$Small.monitoring = false

func highlight():
	$MothmanNew/metarig/Skeleton3D/Bone/Mothman_Lower_Wing_GEO_001.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Bone/Mothman_Lower_Wing_GEO_002.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Antenna_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Arm_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Eye_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_01_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_02_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_03_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_04_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_05_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_06_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_07_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_08_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_08_GEO1.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Head_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Leg_GEO.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Upper_Wing_GEO_001.set_surface_override_material(0, highlightMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Upper_Wing_GEO_002.set_surface_override_material(0, highlightMat)
	skybeam.visible = true
	$HighlightTimer.start()
	
	
func _on_highlight_timer_timeout() -> void:
	$MothmanNew/metarig/Skeleton3D/Bone/Mothman_Lower_Wing_GEO_001.set_surface_override_material(0, wingMat);
	$MothmanNew/metarig/Skeleton3D/Bone/Mothman_Lower_Wing_GEO_002.set_surface_override_material(0, wingMat);
	$MothmanNew/metarig/Skeleton3D/Mothman_Antenna_GEO.set_surface_override_material(0, ffMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Arm_GEO.set_surface_override_material(0, bodyMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Eye_GEO.set_surface_override_material(0, ffMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_01_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_02_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_03_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_04_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_05_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_06_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_07_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_08_GEO.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Fur_08_GEO1.set_surface_override_material(0, furMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Head_GEO.set_surface_override_material(0, bodyMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Leg_GEO.set_surface_override_material(0, bodyMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Upper_Wing_GEO_001.set_surface_override_material(0, wingMat)
	$MothmanNew/metarig/Skeleton3D/Mothman_Upper_Wing_GEO_002.set_surface_override_material(0, wingMat)
	skybeam.visible = false
	
func interact():
	var animName = "move" + str(Global.animNum)
	print("Trying to interact")
	print(str(animName))
	$MothManNoises.stop()
	self.freeze = true
	$Big.monitoring = false
	$Small.monitoring = false
	animPlayer.play(animName)
	await animPlayer.animation_finished
	self.freeze = false
	$MothManNoises.play(0)
	if Global.animNum < 4:
		$Big.monitoring = true
		$Small.monitoring = true
	Global.animNum += 1
	if Global.animNum == 5:
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "Warehouse").finished
	if Global.animNum == 6:
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "Bridge").finished
func killMothmanNoises():
	$MothManNoises.stop()
