extends Node3D

var can_grab = true
var is_in_dog = false

@onready var new_hedge_dog: Node3D = $"."
@onready var pick_up_text: Label3D = $PickUpText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_up_text.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_dog and can_grab:
		new_hedge_dog.queue_free()
		Global.HedgeCompleted = true #finished the Maze
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		pick_up_text.show()
		is_in_dog = true
		pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		pick_up_text.hide()
		is_in_dog = false
		pass # Replace with function body.
