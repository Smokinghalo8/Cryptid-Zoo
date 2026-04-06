extends CharacterBody3D
#@onready var SceneTransitionAnimation = $"../SceneTransitionAnimation"

@export var SPEED = 5.0
const JUMP_VELOCITY = 7
@export var lightOn = false
@onready var animTree = $AnimationTree
@export var walk = false
@export var run = false
@export var idle = true
@export var glide = false
@export var jump = false
@export var senseable = true
var sprintSpeed = 10.0
var maxStamina = 100.0
var staminaDepletionRate = 30.0
var staminaRecoveryRate = 40.0
var sprintable = true
var senseTimeMax = 5.0
var senseTime = senseTimeMax
var senseDeplete = 1.0
var playing = false
var currentVelocity = 0
var previousVelocity = 0
var velocityTolerance = 0.1
var velocityDifference = 0
@onready var objectiveArrow = get_node("/root/" + get_tree().current_scene.name + "/Ui/Minimap/SubViewportContainer/objective_arrow")
@onready var zedAnims = $ZColl/ZedAnims/AnimationPlayer
@onready var zedAnimTree = $ZColl/ZedAnims/AnimationTree

#ethan make glide


func on_ready():
	idle = true
	Global.stamina = maxStamina
	objectiveArrow.visible = false



func _input(event: InputEvent):
	#BodyMovement
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * 0.01)


func _process(delta):
	#sensing
	#Sensing
	
	if Global.playerShouldBeMoving == false:
		SPEED = 0.0
		
	if Global.playerShouldBeMoving == true:
		SPEED = 5.0
	
	
#	$"../Ui/WednigoHead/SenseBar".value = senseTime
	
	if senseTime > 0:
		senseTime -= senseDeplete * delta
		senseTime = clamp(senseTime, 0.0, senseTimeMax)

	
	if Input.is_action_just_pressed("sense") && senseable == true:
		var children = get_tree().current_scene.get_children()
		for child in children:
			if child.is_in_group("Living"):
				
				child.highlight()
				senseable = false
				$SenseTimer.start(0)
				senseTime = 5.0
				$"../Ui/WednigoHead/SenseBar".visible = true
				objectiveArrow.visible = true
				await get_tree().create_timer(3.0).timeout
				objectiveArrow.visible = false
				
			
	
	#Flashlight
	if Input.is_action_just_pressed("flashLight"):
		$Head/FlashLight.visible = not $Head/FlashLight.visible
	
	
	
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.7

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#if velocity.y < 0:
		# Half gravity strength
	#	velocity += get_gravity() * 0.5 * delta
	#	# Apply slight downward velocity
	#	velocity.y = -1
	#	# Reduce speed while falling
	#	SPEED = 9
	#else:
	#	# Normal gravity when rising or on ground
	#	velocity += get_gravity() * delta
		
		

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Global.frozen == false:
		move_and_slide()
		
	#Sprint
	if Input.is_action_pressed("shift") && sprintable == true:
		SPEED = sprintSpeed
		Global.stamina -= staminaDepletionRate * delta
		Global.stamina = min(Global.stamina, maxStamina)

	else:
		Global.stamina += staminaRecoveryRate * delta
		Global.stamina = min(Global.stamina, maxStamina)

	if Global.stamina < 1:
		sprintable = false
		SPEED = 5
		Global.stamina = 0
		await get_tree().create_timer(1.5).timeout
		Global.stamina += staminaRecoveryRate * delta

	if Global.stamina == maxStamina:
		sprintable = true
		
	if Input.is_action_just_released("shift"):
		SPEED = 5
		
	if Input.is_action_just_released("control"):
		$ZColl.scale = Vector3(1, 1, 1)
		SPEED = 5
	
	#Walk Sounds
	currentVelocity = velocity.length()
	velocityDifference = abs(currentVelocity-previousVelocity)
	if velocityDifference > velocityTolerance:
		$Walking.stop()
	previousVelocity = currentVelocity
	
	if not self.is_on_floor():
		$Walking.stop()
		idle = false
		walk = false
		run = false
		jump = true
	
	elif velocity.length() > 6 && not $Walking.playing && self.is_on_floor():
		$Walking.stop()
		$Walking.stream = Global.walkingSound
		$Walking.pitch_scale = 2
		$Walking.volume_db = -10
		$Walking.play(0)
		idle = false
		walk = false
		run = true
		jump = false
		
		
	elif velocity.length() > 4 && not $Walking.playing && self.is_on_floor():
		$Walking.stop()
		$Walking.stream = Global.walkingSound
		$Walking.pitch_scale = 1
		$Walking.volume_db = -10
		$Walking.play(0)
		idle = false
		walk = true
		run = false
		jump = false
		
		
	if velocity.length() < 1:
		$Walking.stop
		idle = true
		walk = false
		run = false
		jump = false
	
	#updateAnimationParameters()
		
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		#SceneTransitionAnimation.play("fade_in")
		position.y += 10
		position.x -= 14
		#SceneTransitionAnimation.play("fade_out")


func _on_sense_timer_timeout() -> void:
	senseable = true
	$"../Ui/WednigoHead/SenseBar".visible = false


func disableLooker():
	$Head/Loooky.process_mode = Node.PROCESS_MODE_DISABLED


func _on_water_body_entered(body: Node3D) -> void:
	self.position.x -= 30
	self.position.y += 20

func updateAnimationParameters():
	zedAnimTree.set("parameters/conditions/idle", idle)
	zedAnimTree.set("parameters/conditions/walk", walk)
	zedAnimTree.set("parameters/conditions/run", run)
	zedAnimTree.set("parameters/conditions/jump", jump)
	#if idle == true:
		##stateMachine.travel("idle")
		#print("Idle")
		#zedAnimTree.set("parameters/conditions/idle", true)
		#zedAnimTree.set("parameters/conditions/walk", false)
		#zedAnimTree.set("parameters/conditions/run", false)
		#zedAnimTree.set("parameters/conditions/jump", false)
	#elif walk == true:
		##stateMachine.travel("walk")
		#print("Walk")
		#zedAnimTree.set("parameters/conditions/idle", false)
		#zedAnimTree.set("parameters/conditions/walk", true)
		#zedAnimTree.set("parameters/conditions/run", false)
		#zedAnimTree.set("parameters/conditions/jump", false)
	#elif run == true:
		##stateMachine.travel("run")
		#print("Run")
		#zedAnimTree.set("parameters/conditions/idle", false)
		#zedAnimTree.set("parameters/conditions/walk", false)
		#zedAnimTree.set("parameters/conditions/run", true)
		#zedAnimTree.set("parameters/conditions/jump", false)
	#elif jump == true:
		##stateMachine.travel("jump")
		#print("Jump")
		#zedAnimTree.set("parameters/conditions/idle", false)
		#zedAnimTree.set("parameters/conditions/walk", false)
		#zedAnimTree.set("parameters/conditions/run", false)
		#zedAnimTree.set("parameters/conditions/jump", true)
