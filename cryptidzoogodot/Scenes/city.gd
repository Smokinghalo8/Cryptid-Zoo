extends Node3D

@onready var _dialog : Control = $Ui/Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_dialog.OldMan1()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
