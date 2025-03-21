extends RayCast3D

var intText

func _ready():
	intText = get_node("/root/" + get_tree().current_scene.name + "/UI/intText")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		var target = get_collider()
		if target != null:
			if target.has_method("interact"):
				intText.visible = true
				if Input.is_action_just_pressed("interact"):
					target.interact()
			else:
				intText.visible = false
		else:
				intText.visible = false
	else:
		intText.visible = false
