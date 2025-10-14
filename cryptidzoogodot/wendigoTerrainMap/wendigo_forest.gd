extends Node3D



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var sprintBar = get_node("/root/" + get_tree().current_scene.name + "/Ui/SprintBar")
	sprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		sprintBar.visible = true
	if Global.stamina == 100:
		sprintBar.visible = false
