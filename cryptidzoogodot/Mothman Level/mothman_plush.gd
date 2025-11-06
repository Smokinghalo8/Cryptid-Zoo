extends Node3D
@onready var plushLabel = get_node("/root/" + get_tree().current_scene.name + "/Ui/PlushControl")

func interact():
	plushLabel.visible = true
	$OpeningPlush.visible = false
	await get_tree().create_timer(0.5).timeout
	Global.plushCounter += 1
	$PartyHorn.play(0)
	await get_tree().create_timer($PartyHorn.stream.get_length()).timeout
	plushLabel.visible = false
	self.queue_free()
