extends CharacterBody3D

@export var speed: float = 5.0
@export var move_radius: float = 10.0
@export var wait_time: float = 1.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_position: Vector3
var waiting: bool = false
var chasing_player: Node = null

func _ready():
	$PlayerDetectionArea.body_entered.connect(_on_body_entered)
	$PlayerDetectionArea.body_exited.connect(_on_body_exited)

	choose_new_target()

func _physics_process(_delta: float) -> void:
	if chasing_player != null and is_instance_valid(chasing_player):
		target_position = chasing_player.global_transform.origin
	else:
		if waiting:
			# Stay still while waiting
			velocity.x = 0
			velocity.z = 0
			apply_gravity(_delta)
			move_and_slide()
			return

		var direction = target_position - global_transform.origin
		direction.y = 0
		if direction.length() < 0.1:
			waiting = true
			# Wait asynchronously
			await get_tree().create_timer(wait_time).timeout
			waiting = false
			choose_new_target()
			return

	var move_direction = (target_position - global_transform.origin)
	move_direction.y = 0
	move_direction = move_direction.normalized()
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed

	apply_gravity(_delta)
	move_and_slide()

	if move_direction.length() > 0.01:
		look_at(global_transform.origin + move_direction, Vector3.UP)

func apply_gravity(_delta: float):
	if not is_on_floor():
		velocity.y -= gravity * _delta
	else:
		velocity.y = 0

func choose_new_target():
	# Pick a random point within move_radius
	var random_offset = Vector3(
		randf_range(-move_radius, move_radius),
		0,
		randf_range(-move_radius, move_radius)
	)
	target_position = global_transform.origin + random_offset

func caught_in_trap():
	print("Caught in trap!")
	speed = 0;

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		chasing_player = body
	if body.is_in_group("Traps"):
		caught_in_trap()

func _on_body_exited(body: Node) -> void:
	if body == chasing_player:
		chasing_player = null
		choose_new_target()

# Shhh I dont know which of this is working properly but they only work if both are in here, just pretend you dont see them. 
func _on_player_detection_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		chasing_player = body
	if body.is_in_group("Traps"):
		caught_in_trap()
func _on_trap_detection_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("Traps"):
		caught_in_trap()
