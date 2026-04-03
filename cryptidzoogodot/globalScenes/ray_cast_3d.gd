extends RayCast3D

var intText
@export var inspect_anchor: Marker3D

func _ready():
	intText = get_node("/root/" + get_tree().current_scene.name + "/Ui/intText")


func _process(delta: float) -> void:
	if is_colliding():
		var target = get_collider()
		print(target)
		if target != null and target.has_method("interact"):
			print("Should be interacting")
			if target.is_in_group("Traps"):
				return
			intText.visible = true
			if Input.is_action_just_pressed("interact"):
				target.interact()
		else:
			intText.visible = false
	else:
		intText.visible = false
