extends RayCast3D

var intText
@export var inspect_anchor: Marker3D

func _ready():
	intText = get_node("/root/" + get_tree().current_scene.name + "/Ui/intText")


func _process(delta: float) -> void:
	if is_colliding():
		var target = get_collider()
		if target != null and target.has_method("interact"):
			if target.is_in_group("Traps"):
				return
				
			intText.visible = true
			if Input.is_action_just_pressed("interact"):
				if target.is_in_group("newspaper"):
					if inspect_anchor != null:
						target.interact(inspect_anchor)
					else:
						print("ERROR: no anchor set")
				else:
					target.interact()
			else:
				intText.visible = false
	else:
		intText.visible = false
