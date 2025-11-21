extends ColorRect

@export var target : NodePath
@export var camera_distance := 20
@export var objective_path: NodePath

@onready var player := get_node(target)
@onready var objective := get_node(objective_path)
@onready var camera := $SubViewportContainer/SubViewport/Camera3D
@onready var arrow := $SubViewportContainer/objective_arrow
@onready var viewport := $SubViewportContainer/SubViewport
@onready var objective_marker := $SubViewportContainer/objective_marker

func _ready() -> void:
	arrow.scale = Vector2(0.2, 0.2)

func _process(delta: float) -> void:
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)
		camera.rotation.y = player.rotation.y
		
		var to_objective = objective.global_position - player.global_position
		
		var local_x = player.transform.basis.x.dot(to_objective)
		var local_z = player.transform.basis.z.dot(to_objective)
		var dir_2d = Vector2(local_x, local_z)
		arrow.rotation = dir_2d.angle() + PI/2
		
		var radius = 50
		var center = Vector2(viewport.size.x / 2, viewport.size.y / 2)
		
		arrow.position = center + dir_2d.normalized() * radius
		
		arrow.rotation = dir_2d.angle() + PI/2
