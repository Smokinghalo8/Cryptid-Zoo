extends MeshInstance3D

@export var interact_distance: float = 3.0
@export var player_node: NodePath

func _process(delta: float) -> void:
	if not player_node:
		return

	var player = get_node_or_null(player_node)
	if not player:
		return

	if global_transform.origin.distance_to(player.global_transform.origin) <= interact_distance:
		if Input.is_action_just_pressed("interact"):
			level_complete()

func level_complete() -> void:
	queue_free()
