extends CharacterBody3D

signal fetch_quest_start
signal roulette_start
signal maze_start
@export var gnome_identifier = 1
@export var dialogue : DialogueResource
var dialogueLines 

#gnome 1 = gnome king - will be added later
#gnome 2 = fetch quest gnome
#gnome 3 = roulette gnome
#gnome 4 = maze gnome

func _on_player_detection_area_body_entered(body: Node3D) -> void:
	if gnome_identifier == 2 and body.is_in_group("Character"):
		fetch_quest_start.emit()
		await DialogueManager.show_dialogue_balloon(dialogue, "fetchGnomeGiveQuest").finished
		print("talking to gnome")
		print(gnome_identifier)
	if gnome_identifier == 3 and body.is_in_group("Character"):
		roulette_start.emit()
		await DialogueManager.show_dialogue_balloon(dialogue, "rouletteGnomeGiveQuest").finished
	if gnome_identifier == 4 and body.is_in_group("Character"):
		
		maze_start.emit()
		
		
func _on_player_detection_area_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
