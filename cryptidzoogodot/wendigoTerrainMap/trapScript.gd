extends Area3D
@onready var wendigo = get_node("/root/WendigoAI")
@onready var interactable = true
@onready var trapped = false
signal activated

func _ready() -> void:
	$TrapColl.disabled = true

func interact():
	if interactable == true:
		$TrapColl.disabled = false
		self.add_to_group("Traps")
		$Glow.visible = false
		interactable = false
		$InteractCol.disabled = true
		activated.emit()
		if self.is_in_group("Traps"):
			print("I'm a trap")


func _on_wendigo_ai_trapped_2() -> void:
	pass # Replace with function body.

func killMe():
	self.queue_free()

func reset():
	$TrapColl.disabled = true
	self.remove_from_group("Traps")
	$Glow.visible = true
	interactable = true
	$InteractCol.disabled = false
	
	
	
