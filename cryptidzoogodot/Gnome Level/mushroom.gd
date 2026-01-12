extends Node3D

var is_in_shroom = false
@export var psychedelic = 0


# export either a boolean or a 1 to set a mushroom as poison/psychedelic so it can potentially
# set randomly in the future
#all mushrooms use this script
#look up screen shaders for a psychedelic effect


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_shroom = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_shroom = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_shroom == true:
		if psychedelic >= 1:
			self.queue_free()
