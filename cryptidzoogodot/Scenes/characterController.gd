extends CharacterBody3D


@export var SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _unhandled_input(event: InputEvent):
	#BodyMovement
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * 0.01)



func _process(delta):
	#ExitTheGame
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("sense"):
		for body in $SenseArea.get_overlapping_bodies():
			if body.is_in_group("Living"):
				print("Body name: " + body.name)
				body.highlight()

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
	
	#Sprint
	if Input.is_action_pressed("shift"):
		SPEED = 10
	if Input.is_action_just_released("shift"):
		SPEED = 5
	
	if Input.is_action_pressed("control"):
		$ZColl.scale = Vector3(1, 0.5, 1)
		SPEED = 2.5
	if Input.is_action_just_released("control"):
		$ZColl.scale = Vector3(1, 1, 1)
		SPEED = 5
