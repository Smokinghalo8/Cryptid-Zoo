extends Area3D




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		$"../ZWendigo".global_position = Vector3(61, 3, -153)
