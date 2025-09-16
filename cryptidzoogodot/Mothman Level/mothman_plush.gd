extends Node3D


func interact():
	Global.plushCounter += 1
	$PartyHorn.play(0)
	await get_tree().create_timer($PartyHorn.stream.get_length())
	self.queue_free()
