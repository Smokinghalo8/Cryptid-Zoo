extends Node3D

@export var dialogue_resource: DialogueResource

func _ready() -> void:
	$TransitionAnims.play("wendyToMM")
	await $TransitionAnims.animation_finished
	get_tree().change_scene_to_file("uid://bf4vgu7u0t3ri")


func playCutscene():
	await DialogueManager.show_dialogue_balloon(dialogue_resource, "BetweenLevels").finished
