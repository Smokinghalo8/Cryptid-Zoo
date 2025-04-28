extends CharacterBody3D
@onready var SceneTransitionAnimation = $"../SceneTransitionAnimation"

@export var SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var lightOn = false
@onready var animTree = $AnimationTree
@export var walk = false
@export var run = false
@export var idle = true
@export var senseable = true
var sprintSpeed = 10.0
var maxStamina = 100.0
var stamina = maxStamina
var staminaDepletionRate = 30.0
var staminaRecoveryRate = 30.0
var sprintable = true




func on_ready():
	idle = true

func _input(event: InputEvent):
	#BodyMovement
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * 0.01)



func _process(delta):
	#ExitTheGame
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("sense") && senseable == true:
		var children = get_tree().current_scene.get_children()
		for child in children:
			if child.is_in_group("Living"):
				child.highlight()
				senseable = false
				$SenseTimer.start(0)
	
	if Input.is_action_just_pressed("flashLight"):
		$Head/FlashLight.visible = not $Head/FlashLight.visible
	
	update_animation_parameters()

		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	#idle
	if(velocity.length() <= 1 && is_on_floor()):
		idle = true
		walk = false
		run = false
	#walk
	elif(velocity.length() == 5 && is_on_floor()):
		walk = true
		idle = false
		run = false
	#run
	elif(velocity.length() == 10 && is_on_floor()):
		run = true
		walk = false
		idle = false
	
	#Sprint
	if Input.is_action_pressed("shift") && sprintable == true:
		SPEED = sprintSpeed
		stamina -= staminaDepletionRate * delta
		stamina = min(stamina, maxStamina)
		print(str(stamina))
	else:
		stamina += staminaRecoveryRate * delta
		stamina = min(stamina, maxStamina)
		print(str(stamina))
	
	if stamina < 1:
		sprintable = false
		SPEED = 5
	if stamina == maxStamina:
		sprintable = true
	if Input.is_action_just_released("shift"):
		SPEED = 5
	
	
	
	#Crouch
	if Input.is_action_pressed("control"):
		$ZColl.scale = Vector3(1, 0.5, 1)
		SPEED = 2.5
	if Input.is_action_just_released("control"):
		$ZColl.scale = Vector3(1, 1, 1)
		SPEED = 5
	
	

func update_animation_parameters():
	if(idle == true):
		animTree["parameters/conditions/idle"] = true
		animTree["parameters/conditions/walk"] = false
		animTree["parameters/conditions/run"] = false
	elif(walk == true):
		animTree["parameters/conditions/idle"] = false
		animTree["parameters/conditions/walk"] = true
		animTree["parameters/conditions/run"] = false
	elif(run == true):
		animTree["parameters/conditions/idle"] = false
		animTree["parameters/conditions/walk"] = false
		animTree["parameters/conditions/run"] = true
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		#SceneTransitionAnimation.play("fade_in")
		position.y += 10
		position.x -= 14
		#SceneTransitionAnimation.play("fade_out")


func _on_sense_timer_timeout() -> void:
	senseable = true
