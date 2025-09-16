extends RigidBody3D

var naturalMat = preload("uid://c24ja6ql5sqp7");
var highlightMat = preload("uid://diycl1rchl5ww")
@onready var animPlayer = get_node("/root/" + get_tree().current_scene.name + "/MothmanAnims")
@onready var _dialog : Control = get_node("/root/" + get_tree().current_scene.name + "/Ui/Dialog")
@onready var OldMan3 = get_node("/root/" + get_tree().current_scene.name + "/Ui/Dialog/OldMan3")
@onready var ChildVoice6 = get_node("/root/" + get_tree().current_scene.name + "/Ui/Dialog/ChildVoice6")
@onready var OldMan5 = get_node("/root/" + get_tree().current_scene.name + "/Ui/Dialog/OldMan5")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MothManNoises.play(0)
	$MothmanFBX/Skeleton3D/Body.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LeftWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RightWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/Head.set_surface_override_material(0, naturalMat);


func highlight():
	$MothmanFBX/Skeleton3D/Body.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/LeftWing.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/RightWing.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/RLeg2.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/LLeg2.set_surface_override_material(0, highlightMat);
	$MothmanFBX/Skeleton3D/Head.set_surface_override_material(0, highlightMat);
	$HighlightTimer.start()
	
	
func _on_highlight_timer_timeout() -> void:
	$MothmanFBX/Skeleton3D/Body.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LeftWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RightWing.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/RLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/LLeg2.set_surface_override_material(0, naturalMat);
	$MothmanFBX/Skeleton3D/Head.set_surface_override_material(0, naturalMat);
	
	
func interact():
	var animName = "move" + str(Global.animNum)
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
		_dialog.OldMan3()
		await get_tree().create_timer(OldMan3.stream.get_length()).timeout
		_dialog.Zed4()
		await get_tree().create_timer(ChildVoice6.stream.get_length()).timeout
		_dialog.OldMan5()
		await get_tree().create_timer(OldMan5.stream.get_length()).timeout
		_dialog.Zed6()
	if Global.animNum == 6:
		_dialog.OldMan6()
func killMothmanNoises():
	$MothManNoises.stop()
