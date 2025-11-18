extends Area3D
@onready var wendigo = get_node("/root/WendigoAI")

@onready var interactable = true

func _ready() -> void:
	$TrapColl.disabled = true

func interact():
	if interactable == true:
		$TrapColl.disabled = false
		self.add_to_group("Traps")
		$Glow.visible = false
		$BearTrap.visible = true
		interactable = false
		$InteractCol.disabled = true
