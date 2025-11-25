extends Node3D

@onready var marble: Node3D = $"."
var is_in_marble = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	is_in_marble = true


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_marble == true:
		#create a boolean to keep track if the marble has been collected or not
		marble.queue_free()


func _on_area_3d_body_exited(body: Node3D) -> void:
	is_in_marble = false
