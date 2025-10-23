extends CharacterBody3D
@onready var _dialog : Control = get_node("/root/" + get_tree().current_scene.name + "/Ui/Dialog")

func interact():
	Global.mothman_Zoo_Compatability += 20
	#_dialog.MothManZoo1()
	#await get_tree().create_timer(MothManZoo1.stream.get_length()).timeout
