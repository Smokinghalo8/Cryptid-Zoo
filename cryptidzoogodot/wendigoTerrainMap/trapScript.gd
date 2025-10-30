extends Area3D
@onready var wendigo = get_node("/root/WendigoAI")

@onready var interactable = true


func interact():
	if interactable == true:
		$Glow.visible = false
		$BearTrap.visible = true
		interactable = false
