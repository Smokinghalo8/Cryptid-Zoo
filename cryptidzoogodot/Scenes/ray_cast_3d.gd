extends RayCast3D

var intText

func _ready():
	intText = get_node("/root/" + get_tree().current_scene.name + "/UI/intText")

func _process(delta: float) -> void:
	if is_colliding():
		print("Is colliding")
		var target = get_collider()
		if target != null:
			print("Not null")
			if target.has_method("interact"):
				intText.visible = true
				print("Has interact")
				if Input.is_action_just_pressed("interact"):
					target.interact()
			else:
				intText.visible = false
		else:
				intText.visible = false
	else:
		intText.visible = false
