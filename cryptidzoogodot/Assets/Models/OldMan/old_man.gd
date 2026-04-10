extends Node3D

@onready var animTree = $AnimationTree
@onready var animPlayer = $AnimationPlayer

@onready var fly = false
@onready var walk = false
@onready var run = false
@onready var idle = true

func _process(delta: float) -> void:
	pass

func goToIdle():
	idle = true
	walk = false
	fly = false
	run = false
	
func goToWalk():
	idle = false
	walk = true
	fly = false
	run = false

func goToRun():
	idle = false
	walk = false
	fly = false
	run = true

func goToFly():
	idle = false
	walk = false
	fly = true
	run = false

func updateAnimParameters():
	animTree.set("parameters/conditions/fly", fly)
	animTree.set("parameters/conditions/run", run)
	animTree.set("parameters/conditions/walk", walk)
	animTree.set("parameters/conditions/idle", idle)
