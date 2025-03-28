extends RigidBody3D


var animNum = 1 


var naturalMat = preload("res://Assets/Materials/fakeMothman.tres");
var highlightMat = preload("res://Assets/Materials/fakeMothmanHighlight.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$FakemothmanCol/FakemothmanMesh.set_surface_override_material(0, naturalMat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func highlight():
	print("Switching")
	var animName = "move" + str(animNum)
	$FakemothmanCol/FakemothmanMesh.set_surface_override_material(0, highlightMat);
	$HighlightTimer.start()
	$MothManAnims.play(animName)
	animNum += 1
	print("animNum: " + str(animNum) + "\nanimName: " + animName)


func _on_highlight_timer_timeout() -> void:
	$FakemothmanCol/FakemothmanMesh.set_surface_override_material(0, naturalMat);
