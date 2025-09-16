extends CharacterBody3D

@export var speed: float = 5.0
@export var move_radius: float = 10.0
@export var wait_time: float = 1.0

var target_position: Vector3
var waiting: bool = false
var chasing_player: Node = null 

func _ready():
	var detection_area = $PlayerDetectionArea
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)
	
	choose_new_target()

func _process(_delta: float) -> void:
	if chasing_player != null and is_instance_valid(chasing_player):
		# Move toward player
		target_position = chasing_player.global_transform.origin
	else:
		# Random wandering
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
	
	# Move toward target position
	var move_direction = (target_position - global_transform.origin).normalized()
	velocity = move_direction * speed
	move_and_slide()
	
	# Face movement direction
	if move_direction.length() > 0.01:
		look_at(global_transform.origin + move_direction, Vector3.UP)

func choose_new_target():
	# Pick a random point within move_radius
	var random_offset = Vector3(
		randf_range(-move_radius, move_radius),
		0,
		randf_range(-move_radius, move_radius)
	)
	target_position = global_transform.origin + random_offset

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		chasing_player = body

func _on_body_exited(body: Node) -> void:
	if body == chasing_player:
		chasing_player = null
		choose_new_target()
