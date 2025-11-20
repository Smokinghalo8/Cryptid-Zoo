extends RigidBody3D

var naturalMat = preload("uid://c24ja6ql5sqp7");
var highlightMat = preload("uid://diycl1rchl5ww")
@onready var animPlayer = get_node("/root/" + get_tree().current_scene.name + "/MothmanAnims")
@onready var skybeam = $Skybeam
@export var dialogue_resource: DialogueResource

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	$MothManNoises.play(0)
	$MothmanFBX/Skeleton3D/Body.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LeftWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RightWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/Head.set_surface_override_material(0, naturalMat);

func _process(delta: float) -> void:
	if Global.animNum <= 1.0:
		$Big.monitoring = false
		$Small.monitoring = false

func highlight():
	$MothmanFBX/Skeleton3D/Body.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/LeftWing.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/RightWing.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/RLeg2.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/LLeg2.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/Head.set_surface_override_material(0, highlightMat);
	skybeam.visible = true
	$HighlightTimer.start()
	
	
func _on_highlight_timer_timeout() -> void:
	$MothmanFBX/Skeleton3D/Body.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LeftWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RightWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/Head.set_surface_override_material(0, naturalMat);
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
