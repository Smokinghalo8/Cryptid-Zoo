extends MeshInstance3D

var highlightMat = preload("uid://diycl1rchl5ww")
var naturalMat = preload("uid://c24ja6ql5sqp7");
@export var interact_distance: float = 3.0
@export var player_node: NodePath
@onready var skybeam = $Skybeam

func _process(delta: float) -> void:
	if not player_node:
		return

	var player = get_node_or_null(player_node)
	if not player:
		return

	if global_transform.origin.distance_to(player.global_transform.origin) <= interact_distance:
		if Input.is_action_just_pressed("interact"):
			level_complete()
			
func highlight():
	self.set_surface_override_material(0, highlightMat);
	skybeam.visible = true
	$HighlightTimer.start()

func _on_highlight_timer_timeout() -> void:
	self.set_surface_override_material(0, naturalMat);
	skybeam.visible = false
	
func level_complete() -> void:
	queue_free()
