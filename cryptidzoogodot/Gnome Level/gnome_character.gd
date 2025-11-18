extends CharacterBody3D

enum State {
	IDLE,
	WAIT,
	CHASE,
}

@export var speed_idle: float = 5.4
@export var speed_chase: float = 5.0
@export var move_radius: float = 10.0
@export var wait_time: float = 2.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var state: State = State.IDLE
var target_position: Vector3
var chasing_player: Node3D = null


@onready var ray_front: RayCast3D = $RayFront
@onready var ray_left: RayCast3D = $RayLeft
@onready var ray_right: RayCast3D = $RayRight
#@onready var player_detection_area: Area3D = $PlayerDetectionArea


func _ready() -> void:
	# Player detection
	#player_detection_area.body_entered.connect(_on_body_entered)
	#player_detection_area.body_exited.connect(_on_body_exited)


	choose_new_target()

func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			_process_idle(delta)
		State.WAIT:
			stop_and_apply_gravity(delta)
		State.CHASE:
			_process_chase(delta)

# --- IDLE wandering ---
func _process_idle(delta: float) -> void:
	var move_direction = _calculate_move_direction(target_position)
	_move_character(move_direction, speed_idle, delta)

	if (global_transform.origin - target_position).length() < 0.1:
		state = State.WAIT
		var t = Timer.new()
		t.wait_time = wait_time
		t.one_shot = true
		add_child(t)
		t.start()
		t.timeout.connect(func():
			choose_new_target()
			state = State.IDLE
			t.queue_free()
		)

# --- Chase player ---
func _process_chase(delta: float) -> void:
	if chasing_player and is_instance_valid(chasing_player):
		target_position = chasing_player.global_transform.origin
		var move_direction = _calculate_move_direction(target_position)
		_move_character(move_direction, speed_chase, delta)
	else:
		state = State.IDLE
		speed_idle = 5.0 
		choose_new_target()

# --- Calculate move direction with raycast avoidance ---
func _calculate_move_direction(target: Vector3) -> Vector3:
	var move_direction = (target - global_transform.origin)
	move_direction.y = 0
	move_direction = move_direction.normalized()

	# Raycast avoidance
	var avoid_direction = Vector3.ZERO
	if ray_front.is_colliding():
		avoid_direction += ray_front.get_collision_normal()
	if ray_left.is_colliding():
		avoid_direction += ray_left.get_collision_normal() * 0.7
	if ray_right.is_colliding():
		avoid_direction += ray_right.get_collision_normal() * 0.7

	if avoid_direction != Vector3.ZERO:
		move_direction = (move_direction + avoid_direction.normalized() * 0.5).normalized()

	return move_direction

# --- Move character helper ---
func _move_character(direction: Vector3, move_speed: float, delta: float) -> void:
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	_apply_gravity(delta)
	move_and_slide()

	if direction.length() > 0.01:
		look_at(global_transform.origin + direction, Vector3.UP)

func stop_and_apply_gravity(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	_apply_gravity(delta)
	move_and_slide()

func _apply_gravity(delta: float) -> void:
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


# --- Player detection ---
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Character"):
		chasing_player = body
		state = State.CHASE

func _on_body_exited(body: Node) -> void:
	if body == chasing_player:
		chasing_player = null
		state = State.IDLE
		speed_idle = 5.0
		choose_new_target()
