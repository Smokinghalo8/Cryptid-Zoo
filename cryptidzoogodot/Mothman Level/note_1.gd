extends StaticBody3D

#@export var dialogue_resource: DialogueResource
#
#func interact():
	#DialogueManager.show_dialogue_balloon(dialogue_resource, "Note1")

var original_pos: Vector3
var original_rot: Vector3
var is_inspecting: bool = false

func interact(anchor: Marker3D):
	if anchor == null: return
		
	if not is_inspecting:
		start_inspection(anchor)
	else:
		stop_inspection()

func start_inspection(anchor: Marker3D):
	is_inspecting = true
	# Store the original position and rotation separately
	original_pos = global_position
	original_rot = global_rotation
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
	# Tween Position
	tween.tween_property(self, "global_position", anchor.global_position, 0.5)
	
	# Tween Rotation to match the anchor
	tween.tween_property(self, "global_rotation", anchor.global_rotation, 0.5)
	
	# If it's still backwards, uncomment the line below to flip it 180 degrees:
	tween.tween_property(self, "rotation_degrees:y", anchor.rotation_degrees.y + 180, 0.5)

func stop_inspection():
	is_inspecting = false
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
	# Return to original world position and rotation
	tween.tween_property(self, "global_position", original_pos, 0.5)
	tween.tween_property(self, "global_rotation", original_rot, 0.5)
