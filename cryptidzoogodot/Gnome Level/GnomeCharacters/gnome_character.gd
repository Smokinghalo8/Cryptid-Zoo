extends CharacterBody3D
#
#enum State {
	#IDLE,
	#WAIT,
	##CHASE,
#}
#
#@export var speed = 4.5
#var hasSeen = false
#var randomPos = 100
#
#var state: State = State.IDLE
#var target_position: Vector3
#var chasing_player: Node3D = null
#
#
#@onready var ray_front: RayCast3D = $RayFront
#@onready var ray_left: RayCast3D = $RayLeft
#@onready var ray_right: RayCast3D = $RayRight
#@onready var player_detection_area: Area3D = $PlayerDetectionArea
#
#
#func _ready() -> void:
	## Player detection
	#player_detection_area.body_entered.connect(_on_body_entered)
	#player_detection_area.body_exited.connect(_on_body_exited)
#
#
	#choose_new_target()
#
#func _physics_process(delta: float) -> void:
	#match state:
		#State.IDLE:
			#_process_idle(delta)
		#State.WAIT:
			#stop_and_apply_gravity(delta)
		##State.CHASE:
			## _process_chase(delta)
#
## --- IDLE wandering ---
#func _process_idle(delta: float) -> void:
	#pass
	#
	#
#func wandering(delta):
	#speed = 7.5
	#var look_pos = global_transform.origin + velocity
	#look_pos.y = self.global_position.y
	#look_at(look_pos)
	#hasSeen = false
	#nav.target_position = randomPos
	#if (abs(randomPos.x - global_position.x) <= 5 and abs(randomPos.z - global_position.z)<=5) or wanderTimer <= 0:
		#randomPos = Vector3(randf_range(player.global_position.x-30, player.global_position.x+30), player.global_position.y, randf_range(player.global_position.z-30, player.global_position.z+30))
		#clamp(randomPos.x, -210, 223)
		#clamp(randomPos.z, -245, 235)
		#wanderTimer = 15.0
	#if (abs(self.global_position.x - player.global_position.x) >= 40 and abs(self.global_position.z - player.global_position.z) >= 40):
		#randomPos = Vector3(randf_range(player.global_position.x-15, player.global_position.x+15), position.y, randf_range(player.global_position.z-15, player.global_position.z+15))
		#clamp(randomPos.x, -210, 223)
		#clamp(randomPos.z, -245, 235)
		#wanderTimer = 15.0
	#wanderTimer-=delta
#
## --- Move character helper ---
#func _move_character(direction: Vector3, move_speed: float, delta: float) -> void:
	#velocity.x = direction.x * move_speed
	#velocity.z = direction.z * move_speed
	#_apply_gravity(delta)
	#move_and_slide()
#
	#if direction.length() > 0.01:
		#look_at(global_transform.origin + direction, Vector3.UP)
#
#func stop_and_apply_gravity(delta: float) -> void:
	#velocity.x = 0
	#velocity.z = 0
	#_apply_gravity(delta)
	#move_and_slide()
#
#func _apply_gravity(delta: float) -> void:
	#if not is_on_floor():
		#velocity.y -= gravity * delta
	#else:
		#velocity.y = 0
#
#func choose_new_target() -> void:
	#var random_offset = Vector3(
		#randf_range(-move_radius, move_radius),
		#0,
		#randf_range(-move_radius, move_radius)
	#)
	#target_position = global_transform.origin + random_offset
#
#
## --- Player detection ---
#func _on_body_entered(body: Node) -> void:
	#if body.is_in_group("Character"):
		#chasing_player = body
		##state = State.CHASE
#
#func _on_body_exited(body: Node) -> void:
	#if body == chasing_player:
		#chasing_player = null
		#state = State.IDLE
		#speed_idle = 5.0
		#choose_new_target()
#
#
#
#func _on_player_detection_area_body_entered(body: Node3D) -> void:
	#pass # Replace with function body.
#
#
#func _on_player_detection_area_body_exited(body: Node3D) -> void:
	#pass # Replace with function body.
