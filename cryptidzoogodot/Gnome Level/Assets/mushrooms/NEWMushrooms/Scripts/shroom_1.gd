extends Node3D

var is_in_shroom = false
@export var psychedelic = 0.0#unsued for now
@onready var pick_up_text: Label3D = $PickUpText
var can_eat = false
var eaten = false
var enough = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_up_text.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_shroom == true and enough == false:
		self.visible = false
		Global.shroomsAte +=1
		if psychedelic >= 1.0:
			await enterPhyscoState()
		if Global.shroomsAte == 2:
			enough = true#stop plasyer from eating
			#after eating 4 make gloabl 21 and send back to king
			Global.gnomeState = 21
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_shroom = true
		pick_up_text.show()
		#can eat
		pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_shroom = false
		pick_up_text.hide()
		#can eat
		pass # Replace with function body.

func enterPhyscoState() -> int:
	#set Visability of PhcysoCube to true, dont use await here, 
	$"../Z/psychedelicCube".visible = true
	eaten = true
	self.visible = false	#why do we make this invisble instead of quese_free? I have no idea, ask Krista
	await get_tree().create_timer(10.0).timeout
	$"../Z/psychedelicCube".visible = false
	
	return 3#just a temp integer, so I cat use await
