extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VolumeSlider.value))
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/PreGameScene.tscn")
	pass # Replace with function body.
