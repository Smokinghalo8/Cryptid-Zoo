extends Node3D

@onready var new_marble: Node3D = $"."
@onready var pick_up_text: Label3D = $PickUpText

var is_in_marble = false
var can_grab = true



#TODO make new dialogue from bleafus if player picked up both items before talking to him
#TODO make sfx, or a text box that fades in/out whenever you pick up item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_up_text.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_marble and can_grab:
		new_marble.queue_free()
		Global.thingsGathered +=1
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		pick_up_text.show()
		is_in_marble = true
		pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		pick_up_text.hide()
		is_in_marble = false
		pass # Replace with function body.
