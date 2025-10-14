extends CharacterBody3D

@export var speed: float = 5.0
@export var move_radius: float = 10.0
@export var wait_time: float = 1.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_position: Vector3
var waiting: bool = false
var chasing_player: Node3D = null

func _ready() -> void:
	# Connect detection area signals
	$PlayerDetectionArea.body_entered.connect(_on_body_entered)
	$PlayerDetectionArea.body_exited.connect(_on_body_exited)
	choose_new_target()

func _physics_process(delta: float) -> void:
	if chasing_player and is_instance_valid(chasing_player):
		# Move toward player
		speed = 2
		target_position = chasing_player.global_transform.origin
	else:
		# Wander randomly if not chasing
		if waiting:
			stop_and_apply_gravity(delta)
			return

		var direction = target_position - global_transform.origin
		direction.y = 0
		if direction.length() < 0.1:
			waiting = true
			await get_tree().create_timer(wait_time).timeout
			waiting = false
			choose_new_target()
			return

	# Move toward target
	var move_direction = (target_position - global_transform.origin)
	move_direction.y = 0
	move_direction = move_direction.normalized()

	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed

	apply_gravity(delta)
	move_and_slide()

	# Rotate toward movement direction
	if move_direction.length() > 0.01:
		look_at(global_transform.origin + move_direction, Vector3.UP)

func stop_and_apply_gravity(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

func choose_new_target() -> void:
	# Pick a random wander point
	speed = 5.0
	var random_offset = Vector3(
		randf_range(-move_radius, move_radius),
		0,
		randf_range(-move_radius, move_radius)
	)
	target_position = global_transform.origin + random_offset

func caught_in_trap() -> void:
	print("Caught in trap!")
	speed = 0
	$TrappedTimer.start(4)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Character"):
		chasing_player = body
	elif body.is_in_group("Traps"):
		caught_in_trap()

func _on_body_exited(body: Node) -> void:
	if body == chasing_player:
		chasing_player = null
		choose_new_target()

func _on_trapped_timer_timeout() -> void:
	choose_new_target()
