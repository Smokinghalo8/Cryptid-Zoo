extends RigidBody3D


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
	$FakemothmanCol/FakemothmanMesh.set_surface_override_material(0, highlightMat);
	$HighlightTimer.start()


func _on_highlight_timer_timeout() -> void:
	$FakemothmanCol/FakemothmanMesh.set_surface_override_material(0, naturalMat);
