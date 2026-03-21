extends Node3D

var is_in_shroom = false
@export var psychedelic = 0.0
var can_eat = false
var eaten = false
signal poisoned
var mushrooms_eaten = 0


# export either a boolean or a 1 to set a mushroom as poison/psychedelic so it can potentially
# set randomly in the future
#all mushrooms use this script


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_shroom = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Character"):
		is_in_shroom = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_in_shroom == true and eaten == false:
		self.visible = false
		eaten = true
		mushrooms_eaten +=1
		if psychedelic >= 1.0:
			$"../../../Z/psychedelicCube".visible = true
			eaten = true
			mushrooms_eaten = 0.0
			await get_tree().create_timer(1.0).timeout
			poisoned.emit()
			await get_tree().create_timer(10.0).timeout
			$"../../../Z/psychedelicCube".visible = false
			self.visible = false
			psychedelic = 0.0
#make 10-12 mushrooms 3-4 are poison, reset when poison is eaten


func reset_shrooms():
	eaten = false
	self.visible = true


func _on_roulette_gnome_roulette_start() -> void:
		can_eat = true
