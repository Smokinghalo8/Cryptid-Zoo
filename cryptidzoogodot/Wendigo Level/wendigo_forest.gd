extends Node3D

@export var dialogue_resource: DialogueResource

@onready var animPlayer : AnimationPlayer = $LevelAnimations
@onready var minimap = $Ui/Minimap

@onready var netBridgeFirst = true
@onready var cemeteryBridgeFirst = true
@onready var extraBridgeFirst = true

var has_visited_forest = false

func _ready() -> void:
	Global.frozen = true
	minimap.arrow.visible = false
	$MainLevelMusic.play(0.0)
	if dialogue_resource:
		#await DialogueManager.show_dialogue_balloon(dialogue_resource, "BeginningOfLevel").finished
		$PlayPenCarrier.queue_free()
		minimap.arrow.visible = true
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
func _on_actual_trap_2_activated() -> void:
	#Trap 4 complete
	if Global.trapCounter == 4:
		minimap.arrow.visible = false
		animPlayer.play("trap4Active")
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap4Complete").finished
		minimap.objective = $BugFixWendy
		Global.wendyFound = false
		minimap.arrow.visible = true
		Global.trapCounter += 1
		Global.checkpoint == true

#Actual trap 3
func _on_trap_3_activated() -> void:
	#Trap 3 complete
	if Global.trapCounter == 3:
		minimap.arrow.visible = false
		animPlayer.play("trap3Active")
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap3Complete").finished
		minimap.objective = $Bridges/CemeteryBridge
		minimap.arrow.visible = true
		Global.trapCounter += 1

#Actual trap 2
func _on_trap_4_activated() -> void:
	#Trap 2 complete
	if Global.trapCounter == 2:
		minimap.arrow.visible = false
		animPlayer.play("trap2Active")
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap2Complete").finished
		minimap.objective = $Bridges/NetBridge
		minimap.arrow.visible = true
		Global.trapCounter += 1

#Actual trap 1
func _on_trap_5_activated() -> void:
	#Trap 1 complete
	if Global.trapCounter == 1:
		minimap.arrow.visible = false
		animPlayer.play("trap1Active")
		await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap1Complete").finished
		minimap.objective = $Trap4
		minimap.arrow.visible = true
		Global.trapCounter += 1
	

func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true


func wendigoTrapped():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "WendigoTrapped").finished

func toWendigo():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "ToWendigo").finished

func killWendyNoise():
	$WendigoAi/AudioStreamPlayer3D.queue_free()
	
func restart():
	Global.frozen = true
	minimap.arrow.visible = false
	$MainLevelMusic.play(0.0)
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "StartSmall").finished
	minimap.arrow.visible = true
	Global.frozen = false


func _on_extra_bridge_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character") && Global.trapCounter == 5 && extraBridgeFirst == true:
		extraBridgeFirst = false
		minimap.objective = $Trap5


func _on_cemetery_bridge_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character") && Global.trapCounter == 4 && cemeteryBridgeFirst == true:
		cemeteryBridgeFirst = false
		minimap.objective = $ActualTrap2


func _on_net_bridge_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character") && Global.trapCounter == 3 && netBridgeFirst == true:
		netBridgeFirst = false
		minimap.objective = $Trap3
