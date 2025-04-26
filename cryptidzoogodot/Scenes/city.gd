extends Node3D

@onready var _dialog : Control = $Ui/Dialog
@export var customSpeed = -1.0
@export var functioning = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_dialog.OldMan1()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if functioning == true:
		for body in $FakeMothman/Big.get_overlapping_bodies():
			if body.is_in_group("Character") && body.velocity.length() > 9.5 && Global.animNum > 1:
				Global.animNum -= 0.5
				var animName = "move" + str(Global.animNum)
				$FakeMothman/Big.monitoring = false
				$FakeMothman/Small.monitoring = false
				$MothmanAnims.play(animName)
				await $MothmanAnims.animation_finished
				if Global.animNum < 4:
					$FakeMothman/Big.monitoring = true
					$FakeMothman/Small.monitoring = true
				Global.animNum -= 0.5
				if Global.animNum >=5:
					functioning = false
			
		for body in $FakeMothman/Small.get_overlapping_bodies():
			if body.is_in_group("Character") && body.velocity.length() > 4.5 && Global.animNum > 1:
				Global.animNum -= 0.5
				var animName = "move" + str(Global.animNum)
				if Global.animNum <= 4:
					$FakeMothman/Big.monitoring = false
					$FakeMothman/Small.monitoring = false
				$MothmanAnims.play(animName)
				await $MothmanAnims.animation_finished
				if Global.animNum < 4:
					$FakeMothman/Big.monitoring = true
					$FakeMothman/Small.monitoring = true
				Global.animNum -= 0.5
				if Global.animNum >=5:
					functioning = false
	
	
