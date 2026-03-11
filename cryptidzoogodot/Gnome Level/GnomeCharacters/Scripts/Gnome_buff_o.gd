extends StaticBody3D

@export var dialogue : DialogueResource
@onready var z: CharacterBody3D = $"../Z"

var GnomeKingPos = Vector3(111, 3, 129)
var dialogueLines 
var start = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		if start:
			#TODO give the teleport a smooth black transition so the teleport is SEEMLESS
			#start of quest, have buff-o give basic dialouge
			Global.playerShouldBeMoving = false
			#await DialogueManager.show_dialogue_balloon(dialogue, "introToGnomeLevel").finished
			Global.playerShouldBeMoving = true
			start = false
			z.global_position = GnomeKingPos
			#move player in front of Gnome King now TODO not implemented AS of yet
