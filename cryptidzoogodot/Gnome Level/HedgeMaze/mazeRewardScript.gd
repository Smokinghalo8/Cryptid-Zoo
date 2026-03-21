extends Node3D

#Create a raycast aswell so the player can interact and 'pickup' the reward

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Player entered the dawg")
	pass #When player runs into the dawg, make some kind of sound(?)
	
