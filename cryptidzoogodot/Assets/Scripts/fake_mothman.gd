extends RigidBody3D

var mothman_Compatibility = 0
var naturalMat = preload("res://Assets/Materials/fakeMothman.tres");
var highlightMat = preload("res://Assets/Materials/fakeMothmanHighlight.tres")
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		
	if Global.animNum == 7:
		Global.MothManZooCheck == 1
		mothman_Compatibility += 20;
		Global.MothManZooCheck == 0 # so that you can't keep adding 20
		
func Compatibility():
	if mothman_Compatibility == 20 && func interact(): :
		#await get_tree().create_timer(MothMan7.stream.get_length()).timeout
		_dialog.MothMan7()
	if mothman_Compatibility == 40 && func interact(): :
		#await get_tree().create_timer(MothMan8.stream.get_length()).timeout
		_dialog.MothMan8()
	if mothman_Compatibility == 60 && func interact(): :
		#await get_tree().create_timer(MothMan9.stream.get_length()).timeout
		_dialog.MothMan9()
	if mothman_Compatibility == 80 && func interact(): :
		#await get_tree().create_timer(MothMan10.stream.get_length()).timeout
		_dialog.MothMan10()
	if mothman_Compatibility == 100 && func interact(): :
		#await get_tree().create_timer(MothMan11.stream.get_length()).timeout
		_dialog.MothMan7()
		
func killMothmanNoises():
	$MothManNoises.stop()
