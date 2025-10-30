extends Area3D
@onready var wendigo = get_node("/root/WendigoAI")

@onready var interactable = true


func interact():
	if interactable == true:
		self.add_to_group("Traps")
		$Glow.visible = false
		$BearTrap.visible = true
		interactable = false
		if self.is_in_group("Traps"):
			print("Yay!")
