extends Node3D

@export var dialogue_resource: DialogueResource

func _ready() -> void:
	
	
	
	if Global.afterWendy == true:
		$WendyEnclosure/Scenery.visible = true
	
	if Global.afterMM == true:
		$MothmanEcnlosureOverview/MothmanEnclosure.visible = true
	
	if Global.afterGnome == true:
		$GnomeEnclosure/Scenery.visible = true
	
	if Global.afterNess == true:
		$NessieEnclosure/Scenery.visible = true
	
	if Global.firstLevel == true:
		$Ui/Minimap/SubViewportContainer/objective_arrow.visible = false
		$CutSceneAnims.play("wakingUp")
		killBarrier()
	
	if Global.firstLevel == false:
		killBarrier()
		$Ui/ColorRect.visible = false

func _process(delta: float) -> void:
	$Ui/SprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false
		
	if $Z.is_on_floor():
		Global.character_position = $Z.global_position


func _on_area_3d_body_entered(body: Node3D) -> void:
	if Global.firstLevel == true && body.is_in_group("Character"):
		$CutSceneAnims.play("onExitHut")
	pass # Replace with function body.


func wakingUpDialogue():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "wakingUp").finished

func gainingTrustDialogue():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "onExitHut").finished

func explainingDialogue():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "overToOldMan").finished

func killBarrier():
	$LevelScenery/Zed_Fort/Barrier.queue_free()

func turnOnObjectiveArrow():
	$Ui/Minimap/SubViewportContainer/objective_arrow.visible = true


func _on_old_man_area_body_entered(body: Node3D) -> void:
	if Global.firstLevel == true && body.is_in_group("Character"):
		Global.firstLevel == false
		$CutSceneAnims.play()

func wendigoLevel():
	get_tree().change_scene_to_file("uid://dxsurf27hc834")
