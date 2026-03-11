extends CharacterBody2D

const TILE_SIZE := 20
const MOVE_SPEED := 25.0

@onready var animationControl: AnimatedSprite2D = $AnimatedSprite2D


var target_position: Vector2
var moving := false

func _ready():
	animationControl.play("idle")
	position = position.snapped(Vector2(TILE_SIZE, TILE_SIZE))
	target_position = position

func _physics_process(delta):
	if moving:
		move_towards_target()
	else:
		handle_input()

func handle_input():
	var direction := Vector2.ZERO

	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN

	if direction != Vector2.ZERO:
		var move_vector = direction * TILE_SIZE
		
		# Test collision before moving
		var collision = move_and_collide(move_vector, true)
		
		if collision == null:
			target_position = position + move_vector
			moving = true

func move_towards_target():
	animationControl.play("Walking")
	var direction = (target_position - position).normalized()
	velocity = direction * MOVE_SPEED
	move_and_slide()

	if position.distance_to(target_position) < 1:
		position = target_position
		velocity = Vector2.ZERO
		moving = false
		animationControl.play("idle")
