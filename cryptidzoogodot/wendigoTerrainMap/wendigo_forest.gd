extends Node3D

func _ready() -> void:
	$WendigoAi.freeze = true
	$ZWendigo.freeze = true
	#insert beginning voice lines here
	
	
	
	$ZWendigo.freeze = false
	$WendigoAi.freeze = false


func _process(delta: float) -> void:
	$Ui/SprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false



func _on_forest_bound_1_body_entered(body: Node3D) -> void:
	#Play flashlight voiceline
	pass


func _on_forest_bound_2_body_entered(body: Node3D) -> void:
	#Play flashlight voiceline
	pass # Replace with function body.
