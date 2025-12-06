extends Node3D

@export var dialogue_resource: DialogueResource

@onready var animPlayer : AnimationPlayer = $LevelAnimations
@onready var minimap = $Ui/Minimap

func _ready() -> void:
	Global.frozen = true
	$MainLevelMusic.play(0.0)
	if dialogue_resource:
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "BeginningOfLevel").finished
	
	
	
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
	#await DialogueManager.show_dialogue_balloon(dialogue_resource, "EnterDarkForest").finished
	pass


func _on_forest_bound_2_body_entered(body: Node3D) -> void:
	#await DialogueManager.show_dialogue_balloon(dialogue_resource, "EnterDarkForest").finished
	pass # Replace with function body.

#Actual trap 4
func _on_trap_2_activated() -> void:
	#Trap 4 complete
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap4Complete").finished
	animPlayer.play("trap4Active")
	minimap.objective = $Trap5

#Actual trap 3
func _on_trap_3_activated() -> void:
	#Trap 3 complete
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap3Complete").finished
	animPlayer.play("trap3Active")
	minimap.objective = $Trap2

#Actual trap 2
func _on_trap_4_activated() -> void:
	#Trap 2 complete
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap2Complete").finished
	animPlayer.play("trap2Active")
	minimap.objective = $Trap3

#Actual trap 1
func _on_trap_5_activated() -> void:
	#Trap 1 complete
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap1Complete").finished
	animPlayer.play("trap1Active")
	minimap.objective = $Trap4
	

func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true
