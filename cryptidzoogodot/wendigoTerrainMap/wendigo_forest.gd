extends Node3D

@onready var animPlayer : AnimationPlayer = $LevelAnimations

func _ready() -> void:
	Global.frozen = true
	$MainLevelMusic.play(0.0)
	#insert beginning voice lines here
	
	
	
	Global.frozen = false


func _process(delta: float) -> void:
	$Ui/SprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false
	
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		togglePause()



func _on_forest_bound_1_body_entered(body: Node3D) -> void:
	#Play flashlight voiceline
	pass


func _on_forest_bound_2_body_entered(body: Node3D) -> void:
	#Play flashlight voiceline
	pass # Replace with function body.

#Actual trap 4
func _on_trap_2_activated() -> void:
	#Trap 4 complete
	animPlayer.play("trap4Active")

#Actual trap 3
func _on_trap_3_activated() -> void:
	#Trap 3 complete
	animPlayer.play("trap3Active")

#Actual trap 2
func _on_trap_4_activated() -> void:
	#Trap 2 complete
	animPlayer.play("trap2Active")

#Actual trap 1
func _on_trap_5_activated() -> void:
	#Trap 1 complete
	animPlayer.play("trap1Active")

func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true
