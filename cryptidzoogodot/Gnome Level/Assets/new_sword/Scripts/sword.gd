extends Node3D

@onready var sword: Node3D = $"."
@onready var pick_up_text: Label3D = $PickUpText


var is_in_sword = false
var can_grab = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_up_text.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_sword and can_grab:
		sword.queue_free()
		Global.thingsGathered +=1
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	pick_up_text.show()
	is_in_sword = true
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	pick_up_text.hide()
	is_in_sword = false
	pass # Replace with function body.
