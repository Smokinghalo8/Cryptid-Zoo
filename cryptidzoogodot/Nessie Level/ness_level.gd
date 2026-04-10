extends Node3D

@export_group("References")
@export var animation_player: AnimationPlayer
@export var lure_1_area: Area3D
@export var lure_2_area: Area3D
@export var lure_3_area: Area3D

@export_group("Animation Names")
@export var roaming_anim: String = "Roaming"
@export var lure_1_anim: String = "Lure1"
@export var lure_2_anim: String = "Lure2"
@export var lure_3_anim: String = "Lure3"
@export var boat_anm: String = "BoatAnm"

# This tracks which function to call when 'E' is pressed
var current_lure_id: int = 0 

func _ready() -> void:
	if not animation_player:
		push_warning("AnimationPlayer is not assigned in the Inspector!")
		return

	# Connect the signal so we know when any animation finishes
	animation_player.animation_finished.connect(_on_animation_finished)

	# Start the default roaming animation
	animation_player.play(roaming_anim)

	# Connect signals and hide items for all 3 lures
	if lure_1_area: _prepare_lure(lure_1_area, 1)
	if lure_2_area: _prepare_lure(lure_2_area, 2)
	if lure_3_area: _prepare_lure(lure_3_area, 3)

func _process(_delta: float) -> void:
	if current_lure_id != 0 and Input.is_action_just_pressed("interact"):
		match current_lure_id:
			1: action_lure_1()
			2: action_lure_2()
			3: action_lure_3()
	
	$Ui/SprintBar.value = Global.stamina	
	if Global.stamina < 100:
		$Ui/SprintBar.visible = true
	if Global.stamina == 100:
		$Ui/SprintBar.visible = false


# This runs automatically whenever any animation finishes
func _on_animation_finished(anim_name: String):
	# If the animation that just finished was one of our lures, go back to roaming
	if anim_name != roaming_anim:
		animation_player.play(roaming_anim)

############# LURES

func start_boat_anm():
	print("Starting Boat Anm...")
	$Z.turnOnHead()
	animation_player.play(boat_anm)
	await animation_player.animation_finished
	$Z.turnOffHead()
	
func action_lure_1():
	print("Activating Lure 1")
	_show_children(lure_1_area)
	animation_player.play(lure_1_anim)
	lure_1_area.monitoring = false
	current_lure_id = 0

func action_lure_2():
	print("Activating Lure 2")
	_show_children(lure_2_area)
	animation_player.play(lure_2_anim)
	lure_2_area.monitoring = false
	current_lure_id = 0

func action_lure_3():
	print("Activating Lure 3")
	_show_children(lure_3_area)
	animation_player.play(lure_3_anim)
	lure_3_area.monitoring = false
	current_lure_id = 0

# --- HELPERS ---

func _prepare_lure(area: Area3D, id: int):
	_hide_children(area)
	# Note: Kept your "Character" group name here!
	area.body_entered.connect(func(body): if body.is_in_group("Character"): current_lure_id = id)
	area.body_exited.connect(func(body): if body.is_in_group("Character") and current_lure_id == id: current_lure_id = 0)

func _hide_children(area: Area3D):
	for child in area.get_children():
		if child is VisualInstance3D or (child is Node3D and not child is CollisionShape3D):
			child.hide()

func _show_children(area: Area3D):
	for child in area.get_children():
		if child is VisualInstance3D or child is Node3D:
			child.show()


func _on_boat_start_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		$Z.turnOnHead()
		start_boat_anm()
		await animation_player.animation_finished
		$Z.turnOffHead()
