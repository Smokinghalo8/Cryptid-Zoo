extends CharacterBody3D

@export var speed: float = 5.0
@export var move_radius: float = 10.0
@export var wait_time: float = 1.0

var target_position: Vector3
var waiting: bool = false

func _ready():
	choose_new_target()

func _process(_delta: float) -> void:
	if waiting:
		return
	
	var direction = (target_position - global_transform.origin)
	var distance = direction.length()
	
	if distance < 0.1:
		waiting = true
		await get_tree().create_timer(wait_time).timeout
		waiting = false
		choose_new_target()
		return
	
	# Move toward target
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	# Face movement direction
	if direction.length() > 0.01:
		look_at(global_transform.origin + direction, Vector3.UP)

func choose_new_target():
	# Pick a random point within radius
	var random_offset = Vector3(
		randf_range(-move_radius, move_radius),
		0,
		randf_range(-move_radius, move_radius)
	)
	target_position = global_transform.origin + random_offset
