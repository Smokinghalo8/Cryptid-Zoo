extends Node3D

@onready var marble: Node3D = $"."
var is_in_marble = false
signal gotMarble
signal lostMarble
var can_grab = true
var quest_started = false

# TODO player can only carry one riddle item at a time


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_marble = true


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_marble == true and can_grab and quest_started:
		marble.queue_free()
		gotMarble.emit()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_marble = false


func _on_sword_got_sword() -> void:
	can_grab = false


func _on_sword_lost_sword() -> void:
	can_grab = true


func _on_fetch_gnome_fetch_quest_start() -> void:
	print("quest received")
	quest_started = true
	#this and the func in sword are likely to have bugs
