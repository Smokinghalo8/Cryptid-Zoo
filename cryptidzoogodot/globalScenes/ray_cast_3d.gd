extends RayCast3D

var intText

func _ready():
	intText = get_node("/root/" + get_tree().current_scene.name + "/Ui/intText")


func _process(delta: float) -> void:
	pass
