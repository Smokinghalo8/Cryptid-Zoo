extends Control

@onready var _speaker : Label = $VBoxContainer/Speaker
@onready var _dialogue : RichTextLabel = $VBoxContainer/Dialogue

func display_line(line : String, speaker : String = ""):
	_speaker.visible = (speaker != "")
	_speaker.text = speaker
	_dialogue.text = line
	open()


func open():
	visible = true
	
func close():
	visible = false
	
func _interact():
	if Input.is_action_pressed("interact"):
		close()
