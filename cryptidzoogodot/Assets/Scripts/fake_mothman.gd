extends RigidBody3D

var naturalMat = preload("res://Assets/Materials/fakeMothman.tres");
var highlightMat = preload("res://Assets/Materials/fakeMothmanHighlight.tres")
@onready var animPlayer = get_node("/root/" + get_tree().current_scene.name + "/MothmanAnims")

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
	print(str(animName))
	
	$Big.monitoring = false
	$Small.monitoring = false
	animPlayer.play(animName)
	await animPlayer.animation_finished
	if Global.animNum < 4:
		$Big.monitoring = true
		$Small.monitoring = true
	Global.animNum += 1
	print("Next anim num: " + str(Global.animNum))
