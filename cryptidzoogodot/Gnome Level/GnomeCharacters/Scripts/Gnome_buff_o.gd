extends StaticBody3D


@export var dialogue : DialogueResource
var dialogueLines 

var start = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if start:
		#start of quest, have buff-o give basic dialouge
		await DialogueManager.show_dialogue_balloon(dialogue, "introToGnomeLevel").finished
		start = false
		#move player in front of Gnome King now TODO not implemented AS of yet
	pass # Replace with function body.
