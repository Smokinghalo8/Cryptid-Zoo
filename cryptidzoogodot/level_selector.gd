extends Node2D

var number = 1

func _process(delta):
	if number == 1:
		$Wendigo.visible = true;
		$Gnome.visible = false;
		$Mothman.visible = false;
		$Nessie.visible = false;
		$GnomeButton.visible = false;
		$MothmanButton.visible = false;
		$NessieButton.visible = false;
	if number == 2:
		$Wendigo.visible = false;
		$Gnome.visible = false;
		$Mothman.visible = true;
		$Nessie.visible = false;
		$GnomeButton.visible = false;
		$MothmanButton.visible = true;
		$NessieButton.visible = false;
	if number == 3:
		$Wendigo.visible = false;
		$Gnome.visible = true;
		$Mothman.visible = false;
		$Nessie.visible = false;
		$GnomeButton.visible = true;
		$MothmanButton.visible = false;
		$NessieButton.visible = false;
	if number == 4:
		$Wendigo.visible = false;
		$Gnome.visible = false;
		$Mothman.visible = false;
		$Nessie.visible = true;
		$GnomeButton.visible = false;
		$MothmanButton.visible = false;
		$NessieButton.visible = true;
		
	if number == 5:
		number -= 4;
	if number == 0:
		number += 4;
		
func _on_backward_pressed() -> void:
	number -= 1
	print(number)


func _on_forward_pressed() -> void:
	number += 1
	print(number)

func fade_out_and_disable():
	var tween = create_tween()
	# 1. Fade the alpha to 0
	tween.tween_property($Gnome, "modulate:a", 0.0, 1.0)
	# 2. Automatically set visible to false once the fade is done
	tween.tween_callback($Gnome.hide)

func fade_in_and_enable():
	# 1. Make it visible first (but it's still transparent from before)
	$Gnome.show()
	var tween = create_tween()
	# 2. Fade the alpha back to 1
	tween.tween_property($Gnome, "modulate:a", 1.0, 1.0)

func _on_gnome_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Gnome Level/GnomeMap.tscn")


func _on_mothman_button_pressed() -> void:
	get_tree().change_scene_to_file("res://globalScenes/city.tscn")


func _on_nessie_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Nessie Level/nessLevel.tscn")


func _on_wendigo_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Wendigo Level/wendigo_forest.tscn")
