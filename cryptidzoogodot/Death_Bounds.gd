extends Area3D
@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		
