extends Node3D

var is_in_sword = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_sword = true


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_sword == true:
		self.queue_free()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_sword = false
