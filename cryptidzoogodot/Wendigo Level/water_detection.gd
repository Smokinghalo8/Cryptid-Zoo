extends Area3D

var isSplashing = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		body.global_position = Global.character_position
		if isSplashing == false:
			isSplashing = true
			$SplashByBlaukreuz6261.play(0.0)
			await get_tree().create_timer(2.0).timeout
			isSplashing = false
