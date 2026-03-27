extends CharacterBody3D

#Nodes
@export var dialogue_resource: DialogueResource
@onready var minimap = get_node("/root/" + get_tree().current_scene.name + "/Ui/Minimap")
@onready var levelPlayer : AnimationPlayer = $"../LevelAnimations"
@onready var wendigoPlayer : AnimationPlayer = $"../WendigoAnims"
@onready var player = get_tree().get_first_node_in_group("Character")

#TrapVariables
@onready var activated2 : bool = false
@onready var activated3 : bool = false
@onready var activated4 : bool = false
@onready var activated5 : bool = false

#NavigationVariables
@onready var nav := $NavigationAgent3D
@onready var speed = 5.0
@onready var chaseSpeed = 5.0
@onready var overlappingNoise = []
@onready var overlappingSeen = []
@onready var isChasing: bool
@onready var isSearching: bool
@onready var randomPos = Vector3(randf_range(-210, 223), position.y, randf_range(-245, 235))
@onready var soundDetector = $SoundDetect
@onready var noiseMade: bool
@onready var chaseSpeedAdd : float = 0.4
var isInSoundDetector : bool
var lastPos
var hasSeen: bool
var wanderTimer : float = 60.0




func _ready() -> void:
	noiseMade = false
	isInSoundDetector = false

func _physics_process(delta):
	
	var bodies = soundDetector.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Character"):
			if Global.wendyFound == false:
				Global.wendyFound = true
				minimap.objective = $"../Trap5"
	
	if player.SPEED >= 9.8:
		noiseMade = true
	
	if isInSoundDetector and noiseMade:
		isChasing = true
		noiseMade = false
		randomPos = player.global_position
	
	if isChasing:
		chase()
	else:
		wandering(delta)
	
	var direction = nav.get_next_path_position()-global_position
	direction.y = 0
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, delta * 10)
	velocity += get_gravity() * delta
	if Global.frozen == false:
		$wendigoWalk/AnimationPlayer.play("Armature|mixamo_com|Layer0", 0)
		move_and_slide()


func chase():
	speed = chaseSpeed
	var look_pos = player.global_position
	look_pos.y = self.global_position.y
	look_at(look_pos)
	nav.target_position = player.global_position

func wandering(delta):
	speed = 7.5
	var look_pos = global_transform.origin + velocity
	look_pos.y = self.global_position.y
	look_at(look_pos)
	hasSeen = false
	nav.target_position = randomPos
	if (abs(randomPos.x - global_position.x) <= 5 and abs(randomPos.z - global_position.z)<=5) or wanderTimer <= 0:
		randomPos = Vector3(randf_range(player.global_position.x-30, player.global_position.x+30), player.global_position.y, randf_range(player.global_position.z-30, player.global_position.z+30))
		clamp(randomPos.x, -210, 223)
		clamp(randomPos.z, -245, 235)
		wanderTimer = 15.0
	if (abs(self.global_position.x - player.global_position.x) >= 40 and abs(self.global_position.z - player.global_position.z) >= 40):
		randomPos = Vector3(randf_range(player.global_position.x-15, player.global_position.x+15), position.y, randf_range(player.global_position.z-15, player.global_position.z+15))
		clamp(randomPos.x, -210, 223)
		clamp(randomPos.z, -245, 235)
		wanderTimer = 15.0
	wanderTimer-=delta


func _on_in_front_detect_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		isChasing = true
	overlappingSeen.append(body)
		
func _on_in_front_detect_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		lastPos = body.global_position
		randomPos = lastPos
		isChasing = false
		overlappingSeen.pop_front()

func _on_sound_detect_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		if Global.wendyFound == false:
			Global.wendyFound = true
			minimap.objective = $"../Trap5"
		isInSoundDetector = true
		overlappingNoise.append(body)
		if Global.wendyFound == false:
			Global.wendyFound = true
			minimap.objective = $"../Bridges/ExtraBridge"

func _on_sound_detect_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		isInSoundDetector = false
		isChasing = false
		overlappingNoise.pop_front()

### ACT TRAP 4
func _on_actual_trap_2_body_entered(body: Node3D) -> void:
	if $"../ActualTrap2".is_in_group("Traps"):
		if body.is_in_group("Enemies"):
			if Global.trapCounter == 8:
				print("Final trap triggered")
				wendigoPlayer.play("wendTrap4")
				await wendigoPlayer.animation_finished
				activated2 = false
				$CutSceneCam.current = true
				Global.frozen = true
				levelPlayer.play("FinalCutscene")
				await levelPlayer.animation_finished
				Global.plushCounter = 0
				get_tree().change_scene_to_file("res://Cryptid_Zoo_Map.tscn")

			
### Act trap 3
func _on_trap_3_body_entered(body: Node3D) -> void:
	if $"../Trap3".is_in_group("Traps"):
		if body.is_in_group("Enemies"):
			if Global.trapCounter == 7:
				minimap.arrow.visible = false
				wendigoPlayer.play("wendTrap3")
				await wendigoPlayer.animation_finished
				#insert trap escape line 3
				await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap3Escaped").finished
				activated3 = false
				Global.trapCounter += 1
				chaseSpeed += chaseSpeedAdd
				minimap.objective = $"../Trap2"
				minimap.arrow.visible = true
				$"../Trap3".visible = false
				$"../Trap3".PROCESS_MODE_DISABLED

### ACT TRAP 2
func _on_trap_4_body_entered(body: Node3D) -> void:
	if $"../Trap4".is_in_group("Traps"):
		if body.is_in_group("Enemies"):
			if Global.trapCounter == 6:
				minimap.arrow.visible = false
				wendigoPlayer.play("wendTrap2")
				await wendigoPlayer.animation_finished
				#insert trap escape line 2
				await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap2Escaped").finished
				activated4 = false
				Global.trapCounter += 1
				chaseSpeed += chaseSpeedAdd
				minimap.objective = $"../Trap3"
				minimap.arrow.visible = true
				$"../Trap4".visible = false
				$"../Trap4".PROCESS_MODE_DISABLED

## ACT TRAP 1
func _on_trap_5_body_entered(body: Node3D) -> void:
	if $"../Trap5".is_in_group("Traps"):
		if body.is_in_group("Enemies"):
			if Global.trapCounter == 5:
				minimap.arrow.visible = false
				wendigoPlayer.play("wendTrap1")
				await wendigoPlayer.animation_finished
				#insert trap escape line 1
				await DialogueManager.show_dialogue_balloon(dialogue_resource, "Trap1Escaped").finished
				activated5 = false
				Global.trapCounter += 1
				chaseSpeed += chaseSpeedAdd
				minimap.objective = $"../Trap4"
				minimap.arrow.visible = true
				$"../Trap5".visible = false
				$"../Trap5".PROCESS_MODE_DISABLED


func _on_trap_5_activated() -> void:
	activated5 = true


func _on_trap_3_activated() -> void:
	activated3 = true


func _on_actual_trap_2_activated() -> void:
	activated2 = true


func _on_trap_4_activated() -> void:
	activated4 = true

func restart():
	minimap.objective = $"../Trap5"
	$"../LevelAnimations".play("RESET")
	$"..".restart()
	$"../ActualTrap2".reset()
	$"../Trap3".reset()
	$"../Trap4".reset()
	$"../Trap5".reset()
	isChasing = false
	randomPos = Vector3(randf_range(player.global_position.x-30, player.global_position.x+30), position.y, randf_range(player.global_position.z-30, player.global_position.z+30))
	clamp(randomPos.x, -210, 223)
	clamp(randomPos.z, -245, 235)
	Global.trapCounter = 1
	
func restartCheckpoint():
	$"../LevelAnimations".play("reset_checkpoint")
	Global.trapCounter = 5
	isChasing = false
	randomPos = Vector3(randf_range(player.global_position.x-30, player.global_position.x+30), position.y, randf_range(player.global_position.z-30, player.global_position.z+30))
	clamp(randomPos.x, -210, 223)
	clamp(randomPos.z, -245, 235)
	minimap.objective = self
	$"../Trap5".visible = true
	$"../Trap5".PROCESS_MODE_INHERIT
	$"../Trap4".visible = true
	$"../Trap4".PROCESS_MODE_INHERIT
	$"../Trap3".visible = true
	$"../Trap3".PROCESS_MODE_INHERIT


func _on_jump_scaries_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		if Global.checkpoint == false:
			restart()
		if Global.checkpoint == true:
			restartCheckpoint()
