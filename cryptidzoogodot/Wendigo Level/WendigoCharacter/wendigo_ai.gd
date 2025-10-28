extends CharacterBody3D

@export var speed: float = 5.0
@export var move_radius: float = 10.0
@export var wait_time: float = 1.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_position: Vector3
var waiting: bool = false
var chasing_player: Node3D = null

@onready var ray_front: RayCast3D = $RayFront
@onready var ray_left: RayCast3D = $RayLeft
@onready var ray_right: RayCast3D = $RayRight

func _ready() -> void:
	$PlayerDetectionArea.body_entered.connect(_on_body_entered)
	$PlayerDetectionArea.body_exited.connect(_on_body_exited)
	choose_new_target()

func _physics_process(delta: float) -> void:
	var move_direction = Vector3.ZERO

	# --- Targeting ---
	if chasing_player and is_instance_valid(chasing_player):
		speed = 2
		target_position = chasing_player.global_transform.origin
	else:
		speed = 5.0
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

	move_direction = (target_position - global_transform.origin).normalized()

	# --- Raycast avoidance ---
	var avoid_direction = Vector3.ZERO
	if ray_front.is_colliding():
		avoid_direction += ray_front.get_collision_normal()
	if ray_left.is_colliding():
		avoid_direction += ray_left.get_collision_normal() * 0.7
	if ray_right.is_colliding():
		avoid_direction += ray_right.get_collision_normal() * 0.7

	if avoid_direction != Vector3.ZERO:
		# Blend avoidance gently with movement to prevent spazzing
		move_direction = (move_direction + avoid_direction.normalized() * 0.5).normalized()

	# --- Movement ---
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	apply_gravity(delta)
	move_and_slide()

	# --- Rotation ---
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
