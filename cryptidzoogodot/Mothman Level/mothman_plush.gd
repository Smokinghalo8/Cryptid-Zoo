extends Node3D


func interact():
	var plushLabel = get_node("/oot/City/Ui/PlushControl")
	plushLabel.visible = true
	get_tree().create_timer(0.5)
	Global.plushCounter += 1
	$PartyHorn.play(0)
	await get_tree().create_timer($PartyHorn.stream.get_length())
	plushLabel.visible = false
	self.queue_free()
