extends RayCast3D

var intText

func _ready():
	intText = get_node("/root/" + get_tree().current_scene.name + "/Ui/intText")


func _process(delta: float) -> void:
	if is_colliding():
		var target = get_collider()
		if target != null:
			if target.has_method("interact") && Input.is_action_just_pressed("interact"):
				intText.visible = true
				target.interact()
			else:
				intText.visible = false
	else:
		intText.visible = false
