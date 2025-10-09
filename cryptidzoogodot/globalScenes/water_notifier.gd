extends Node3D


@onready var guided_object = self
@onready var camera = get_parent().get_node("Head")
@onready var body = get_parent()
@onready var depth_sensor : RayCast3D = $depthSensor
@onready var water_detector : Area3D = $waterDetector


var depth : float = 0.0


#func _process(delta) -> void:
	#body.in_water = bool(water_detector.get_overlapping_areas().size())
	##if body.in_water and depth.sensor.is_colliding():
	#depth = to_local(depth_sensor.get_collision_point()).y
	#if body.in_water and not depth_sensor.is_colliding():
		#depth = 2.0
	#elif not body.in_water and not depth_sensor.is_colliding():
		#depth = 0.0
	#print(depth)
	

func get_depth():
	return depth
