extends Node3D

func _ready() -> void:
	if Global.afterWendy == true:
		$WendyEnclosure/Scenery.visible = true
	
	if Global.afterMM == true:
		$MothmanEcnlosureOverview/MothmanEnclosure.visible = true
	
	if Global.afterGnome == true:
		$GnomeEnclosure/Scenery.visible = true
	
	if Global.afterNess == true:
		$NessieEnclosure/Scenery.visible = true

func _process(delta: float) -> void:
	$Ui/SprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false
		
	if $Z.is_on_floor():
		Global.character_position = $Z.global_position


func _on_area_3d_body_entered(body: Node3D) -> void:
	#insert animation that takes him into the next day
	pass # Replace with function body.
