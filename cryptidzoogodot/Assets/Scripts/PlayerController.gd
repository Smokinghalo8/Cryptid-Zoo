extends CharacterBody3D

@export var speed = 4
@export var jumpSpeed = 5
@export var gravity = -9.81

func _unhandled_input(event: InputEvent):
	#BodyMovement
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * 0.01)



func _process(delta):
	#ExitTheGame
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _physics_process(delta: float):
	#Move
	var inputDir = Input.get_vector("left", "right", "forward", "back")
	var direction = (self.transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		velocity.y += gravity * delta
		move_and_slide()
		
	#Sprint
	if Input.is_action_pressed("shift"):
		speed = 6
	if Input.is_action_just_released("shift"):
		speed = 4
	
	#Jump
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jumpSpeed
	

	#Crouch
	if Input.is_action_pressed("control"):
		$ZColl.scale = Vector3(1, 0.75, 1) 
		$Head.position.y = 0.25
		$Head/Loooky.position.y = 0.25
		speed = 2
	if Input.is_action_just_released("control"):
		$ZColl.scale = Vector3(1, 1, 1) 
		$Head.position.y = 0.5
		$Head/Loooky.position.y = 0.5
		speed = 4
