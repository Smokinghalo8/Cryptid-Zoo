extends Node3D

@export var dialogue_resource: DialogueResource
@export var findWendigo = false

@onready var animPlayer : AnimationPlayer = $LevelAnimations
@onready var minimap = $Ui/Minimap

var has_visited_forest = false

func _ready() -> void:
	Global.frozen = true
	minimap.arrow.visible = false
	$MainLevelMusic.play(0.0)
	#if dialogue_resource:
#		await DialogueManager.show_dialogue_balloon(dialogue_resource, "BeginningOfLevel").finished
#		minimap.arrow.visible = true
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
	if body.is_in_group("Character") and not has_visited_forest:
		has_visited_forest = true
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "EnterDarkForest").finished


func _on_forest_bound_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character") and not has_visited_forest:
		has_visited_forest = true
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "EnterDarkForest").finished

#Actual trap 4
func _on_trap_2_activated() -> void:
	#Trap 4 complete
	minimap.arrow.visible = false
	animPlayer.play("trap4Active")
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap4Complete").finished
	minimap.objective = $WendigoAi
	findWendigo = true
	minimap.arrow.visible = true

#Actual trap 3
func _on_trap_3_activated() -> void:
	#Trap 3 complete
	minimap.arrow.visible = false
	animPlayer.play("trap3Active")
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap3Complete").finished
	minimap.objective = $Trap2
	minimap.arrow.visible = true

#Actual trap 2
func _on_trap_4_activated() -> void:
	#Trap 2 complete
	minimap.arrow.visible = false
	animPlayer.play("trap2Active")
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap2Complete").finished
	minimap.objective = $Trap3
	minimap.arrow.visible = true

#Actual trap 1
func _on_trap_5_activated() -> void:
	#Trap 1 complete
	minimap.arrow.visible = false
	animPlayer.play("trap1Active")
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap1Complete").finished
	minimap.objective = $Trap4
	minimap.arrow.visible = true
	

func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true


func wendigoTrapped():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "WendigoTrapped").finished

func toWendigo():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "ToWendigo").finished

func killWendyNoise():
	$WendigoAi/AudioStreamPlayer3D.queue_free()
