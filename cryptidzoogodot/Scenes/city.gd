extends Node3D

@onready var _dialog : Control = $Ui/Dialog
@export var customSpeed = -1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_dialog.OldMan1()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in $FakeMothman/Big.get_overlapping_bodies():
		if body.is_in_group("Character") && body.velocity.length() > 9.5 && Global.animNum > 1:
			Global.animNum -= 0.5
			var animName = "move" + str(Global.animNum)
			print("Anim playing: " + str(animName))
			$MothmanAnims.play(animName)
			Global.animNum -= 0.5
			
	for body in $FakeMothman/Small.get_overlapping_bodies():
		if body.is_in_group("Character") && body.velocity.length() > 4.5 && Global.animNum > 1:
			Global.animNum -= 0.5
			var animName = "move" + str(Global.animNum)
			print("Anim playing: " + str(animName))
			$MothmanAnims.play(animName, -1.0)
			Global.animNum -= 0.5
	
	
