extends Control

@onready var _speaker : Label = $VBoxContainer/Speaker
@onready var _dialogue : RichTextLabel = $VBoxContainer/Dialogue
var Child_Color = Color(0, 255, 233)  # Light Blue
var Oldman_Color = Color(0, 255, 6)  # Dark Green
var Moth_Color = Color(173, 0, 0)  # Dark Red
var Note_Color = Color(255, 255, 255) # White 

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

func OldMan1():
		display_line("Mothman is somewhere in this small town, our job is to try and catch it.", "OldMan")
		await get_tree().create_timer(5).timeout
		display_line("With the power of the Wendigo, you can use nightvision by pressing [Q] to see", "OldMan")
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func OldMan2():
		_speaker.set("theme_override_colors/font_color", Oldman_Color)
		_dialogue.set("theme_override_colors/font_color", Oldman_Color)
		display_line("Be careful, he might fly away if you scare it. ", "OldMan")
		await get_tree().create_timer(5).timeout
		self.visible = false
	
func OldMan3():
		_speaker.set("theme_override_colors/font_color", Oldman_Color)
		_dialogue.set("theme_override_colors/font_color", Oldman_Color)
		display_line("I think I saw him fly to the warehouse near the parking lot, try checking there.", "OldMan")
		await get_tree().create_timer(5).timeout
		self.visible = false

func MothMan1():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("P*ea*.. G* *w*y....", "MothMan")
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func MothMan2():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("I*'s n** Sa*e H**e", "MothMan")
		await get_tree().create_timer(5).timeout
		self.visible = false

func MothMan3():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("Don'* Try *o *atch me", "MothMan")
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func MothMan4():
		display_line("No where is safe", "MothMan")
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func MothMan5():
		display_line("The people here, they try to hunt me", "MothMan")
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func LIlKid1():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("I know a place you can be safe", "Little Kid")
		$"../../ChildVoice1".play()
		await get_tree().create_timer(5).timeout
		self.visible = false

func LIlKid2():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("I run a zoo for cryptids like you! A sactuary where you wont have to run anymore.", "Little Kid")
		$"../../ChildVoice2".play()
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func CityNotes1():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("*Missing Mothman plushie Poster* | seems it was last seen near the park.", "Little Kid")
		$"../../NotesVoice1".play()
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func CityNotes2():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("*Mothman Terrorizes Point Pleasant!* | seems it's a newspaper thread.", "Little Kid")
		$"../../NotesVoice2".play()
		await get_tree().create_timer(5).timeout
		self.visible = false
		
func CityNotes3():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("*Drawing of a tall stick man around sharp trees* | I get a weird feeling looking at this.", "Little Kid")
		$"../../NotesVocie3".play()
		await get_tree().create_timer(5).timeout
		self.visible = false

func CityNotes4():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("Don't Cross this bridge! | looks really unsafe.", "Little Kid")
		$"../../NotesVoice4".play()
		await get_tree().create_timer(5).timeout
		self.visible = false
