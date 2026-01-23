extends Node3D

var is_in_sword = false
var can_grab = true
signal got_sword
signal lost_sword


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_sword = true


func process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_sword == true and can_grab:
		self.queue_free()
		got_sword.emit()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_sword = false


func _on_marble_got_marble() -> void:
	can_grab = false


func _on_marble_lost_marble() -> void:
	can_grab = true
