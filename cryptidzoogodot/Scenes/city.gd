extends Node3D

@onready var _dialog : Control = $Ui/Dialog
@export var customSpeed = -1.0
@export var functioning = true
var scaryNoiseFirstTime = true
var flyBack = true
var cutScene = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SceneTransitionAnimation.play("fade_out")
	scaryNoiseFirstTime = false
	$MothmanAnims.play("RESET")
	Global.stamina = 100
	$CutScene/CutSceneAnims.play("FadeIn")
	await $CutScene/CutSceneAnims.animation_finished
	_dialog.OldMan1()
	scaryNoiseFirstTime = true
	cutScene = true
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for body in $CityLimits.get_overlapping_bodies():
		if body.is_in_group("Character"):
			Global.walkingSound = load("uid://s1h8u82saymf")
	
	for body in $Mountain.get_overlapping_bodies():
		if body.is_in_group("Character"):
			Global.walkingSound = load("uid://2l7yfg02rrdx")
	
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		togglePause()
	

	
	$Ui/SprintBar.value = Global.stamina
	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false
	
	if functioning == true:
		for body in $FakeMothman/Big.get_overlapping_bodies():
			if body.is_in_group("Character") && body.velocity.length() > 9.5 && Global.animNum > 1:
				Global.animNum -= 0.5
				var animName = "move" + str(Global.animNum)
				$FakeMothman.freeze = true
				$FakeMothman/Big.monitoring = false
				$FakeMothman/Small.monitoring = false
				$MothmanAnims.play(animName)
				await $MothmanAnims.animation_finished
				$FakeMothman.freeze = false
				if Global.animNum < 4:
					$FakeMothman/Big.monitoring = true
					$FakeMothman/Small.monitoring = true
				Global.animNum -= 0.5
				if Global.animNum >=5:
					functioning = false
				if flyBack == true:
					_dialog.Zed5()
					await get_tree().create_timer($Ui/Dialog/ChildVoice3.stream.get_length()).timeout
					_dialog.OldMan2()
					flyBack = false
			
		for body in $FakeMothman/Small.get_overlapping_bodies():
			if body.is_in_group("Character") && body.velocity.length() > 4.5 && Global.animNum > 1:
				Global.animNum -= 0.5
				var animName = "move" + str(Global.animNum)
				$FakeMothman.freeze = true
				$FakeMothman/Big.monitoring = false
				$FakeMothman/Small.monitoring = false
				$MothmanAnims.play(animName)
				await $MothmanAnims.animation_finished
				$FakeMothman.freeze = false
				if Global.animNum < 4:
					$FakeMothman/Big.monitoring = true
					$FakeMothman/Small.monitoring = true
				Global.animNum -= 0.5
				if Global.animNum >=5:
					functioning = false
				if flyBack == true:
					_dialog.Zed5()
					await get_tree().create_timer($Ui/Dialog/ChildVoice3.stream.get_length()).timeout
					_dialog.OldMan2()
					flyBack = false
	
func togglePause():
	get_tree().paused = true
	$"Ui/Pause Menu".visible = true


func _on_big_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character") && scaryNoiseFirstTime == true:
		_dialog.Zed3()
		await get_tree().create_timer($Ui/Dialog/ChildVoice4.stream.get_length()).timeout
		_dialog.OldMan4()
		scaryNoiseFirstTime = false




func _on_cut_scene_collider_2_body_entered(body: Node3D) -> void:
	if cutScene == true:
		if Global.animNum == 6:
			$CutScene/CutSceneCam.current = true
			$CutScene/CutSceneAnims.play("mothMan")
			await $CutScene/CutSceneAnims.animation_finished
			get_tree().quit()


func _on_cut_scene_collider_body_entered(body: Node3D) -> void:
	if cutScene == true: 
		if Global.animNum == 6:
			$CutScene/CutSceneCam.current = true
			$CutScene/CutSceneAnims.play("mothMan")
			get_tree().quit()
