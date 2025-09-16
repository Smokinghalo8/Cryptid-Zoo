extends Control

@onready var _speaker : Label = $VBoxContainer/Speaker
@onready var _dialogue : RichTextLabel = $VBoxContainer/Dialogue
var Child_Color = Color(0, 255, 233)  # Light Blue
var Oldman_Color = Color(0, 255, 6)  # Dark Green
var Moth_Color = Color(173, 0, 0)  # Dark Red
var Note_Color = Color(255, 255, 255) # White 
@onready var mothmanLine1 = get_node("/root/" + get_tree().current_scene.name + "/FakeMothman/MothmanLine1Trimmed")
@onready var mothmanLine2 = get_node("/root/" + get_tree().current_scene.name + "/FakeMothman/MothmanLine2Trimmed")
@onready var mothmanLine3 = get_node("/root/" + get_tree().current_scene.name + "/FakeMothman/MothmanLine3Trimmed")
@onready var mothmanLine4 = get_node("/root/" + get_tree().current_scene.name + "/FakeMothman/MothmanLine4Trimmed")
@onready var mothmanLine5 = get_node("/root/" + get_tree().current_scene.name + "/FakeMothman/MothmanLine5Trimmed")
@onready var mothmanLine6 = get_node("/root/" + get_tree().current_scene.name + "/FakeMothman/MothmanLine6Trimmed")


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
		$OldMan1.play(0)
		display_line("Mothman is somewhere in this small town, our job is to try and catch it.", "OldMan")
		await get_tree().create_timer($OldMan1.stream.get_length()).timeout
		$OldMan2.play(0)
		display_line("For this mission, I've granted you the power of the Wednigo, so if you press [Q], you'll be able to see Mothman using night vision", "OldMan")
		await get_tree().create_timer($OldMan2.stream.get_length()).timeout
		self.visible = false
		
		
func OldMan2():
		_speaker.set("theme_override_colors/font_color", Oldman_Color)
		_dialogue.set("theme_override_colors/font_color", Oldman_Color)
		display_line("Yes, be careful, you may want to sneak up on him by crouching as to not scare him ", "OldMan")
		$OldMan2Real.play(0)
		await get_tree().create_timer($OldMan2Real.stream.get_length()).timeout
		self.visible = false
	
	
func OldMan3():
		_speaker.set("theme_override_colors/font_color", Oldman_Color)
		_dialogue.set("theme_override_colors/font_color", Oldman_Color)
		$OldMan3.play(0)
		display_line("I think I saw him fly to the warehouse near the parking lot, try checking there.", "OldMan")
		await get_tree().create_timer($OldMan3.stream.get_length()).timeout
		self.visible = false


func OldMan4():
	_speaker.set("theme_override_colors/font_color", Oldman_Color)
	_dialogue.set("theme_override_colors/font_color", Oldman_Color)
	$OldMan4.play(0)
	display_line("Don't worry, Mothman is a docile creature, he won't try to harm you", "OldMan")
	await get_tree().create_timer($OldMan4.stream.get_length()).timeout
	self.visible = false


func OldMan5():
	_speaker.set("theme_override_colors/font_color", Oldman_Color)
	_dialogue.set("theme_override_colors/font_color", Oldman_Color)
	$OldMan5.play(0)
	display_line("Because he doesn't understand that we're trying to help him, Zed. He thinks we're just like the rest of the people in this town", "OldMan")
	await get_tree().create_timer($OldMan5.stream.get_length()).timeout
	self.visible = false


func OldMan6():
	_speaker.set("theme_override_colors/font_color", Oldman_Color)
	_dialogue.set("theme_override_colors/font_color", Oldman_Color)
	$OldMan6.play(0)
	display_line("I think he just flew over the bridge out of town towards the mountainds! Quickly, give chase before he gets away!", "OldMan")
	await get_tree().create_timer($OldMan6.stream.get_length()).timeout
	self.visible = false


func MothMan1():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("P*ea*.. G* *w*y....", "MothMan")
		await get_tree().create_timer(mothmanLine1.stream.get_length()).timeout
		self.visible = false
		
		
func MothMan2():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("I*'s n** Sa*e H**e", "MothMan")
		await get_tree().create_timer(mothmanLine2.stream.get_length()).timeout
		self.visible = false


func MothMan3():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("Don'* Try *o *atch me", "MothMan")
		await get_tree().create_timer(mothmanLine3.stream.get_length()).timeout
		self.visible = false
		
		
func MothMan4():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("No where is safe", "MothMan")
		await get_tree().create_timer(mothmanLine4.stream.get_length()).timeout
		self.visible = false
		
		
func MothMan5():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("The people here, they try to hunt me", "MothMan")
		await get_tree().create_timer(mothmanLine5.stream.get_length()).timeout
		self.visible = false


func MothMan6():
		_speaker.set("theme_override_colors/font_color", Moth_Color)
		_dialogue.set("theme_override_colors/font_color", Moth_Color)
		display_line("Really?", "MothMan")
		await get_tree().create_timer(mothmanLine6.stream.get_length()).timeout
		self.visible = false

		
func Zed1():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("I know a place you can be safe", "Zed")
		$"../../ChildVoice1".play()
		await get_tree().create_timer(5).timeout
		self.visible = false


func Zed2():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("I run a zoo for cryptids like you! A sactuary where you wont have to run anymore.", "Zed")
		$"../../ChildVoice2".play()
		await get_tree().create_timer(5).timeout
		self.visible = false


func Zed3():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("He's making a lot of scary noises", "Zed")
		$ChildVoice4.play(0)
		await get_tree().create_timer($ChildVoice4.stream.get_length()).timeout
		self.visible = false


func Zed4():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("Why are we trying to capture him if he doesn't want to come back?", "Zed")
		$ChildVoice6.play(0)
		await get_tree().create_timer($ChildVoice6.stream.get_length()).timeout
		self.visible = false


func Zed5():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("He ran away before I could try and talk to him", "Zed")
		$ChildVoice3.play(0)
		await get_tree().create_timer($ChildVoice3.stream.get_length()).timeout
		self.visible = false


func Zed6():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("Okay, that makes sense", "Zed")
		$ChildVoice7.play(0)
		await get_tree().create_timer($ChildVoice7.stream.get_length()).timeout
		self.visible = false
		
		
func Zed7():
		_speaker.set("theme_override_colors/font_color", Child_Color)
		_dialogue.set("theme_override_colors/font_color", Child_Color)
		display_line("I know a place where you can be safe", "Zed")
		await get_tree().create_timer($ChildVoice1.stream.get_length()).timeout
		self.visible = false


func Zed8():
	_speaker.set("theme_override_colors/font_color", Child_Color)
	_dialogue.set("theme_override_colors/font_color", Child_Color)
	display_line("I run a zoo for cryptids like you, a sanctuary where you won't have to run anymore", "Zed")
	await get_tree().create_timer($ChildVoice2.stream.get_length()).timeout
	self.visible = false


func Zed9():
	_speaker.set("theme_override_colors/font_color", Child_Color)
	_dialogue.set("theme_override_colors/font_color", Child_Color)
	display_line("I promise I'm not gonna hurt you", "Zed")
	await get_tree().create_timer($ChildVoice8.stream.get_length()).timeout
	self.visible = false


func CityNotes1():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("*Missing Mothman plushie Poster* | seems it was last seen near the park.", "Zed")
		$Notes1.play()
		await get_tree().create_timer($Notes1.stream.get_length() + 3).timeout
		self.visible = false
		
		
func CityNotes2():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("*Mothman Terrorizes Point Pleasant!* | seems it's a newspaper thread.", "Zed")
		$Notes2.play()
		await get_tree().create_timer($Notes2.stream.get_length() + 3).timeout
		self.visible = false
		
		
func CityNotes3():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("*Drawing of a tall stick man around sharp trees* | I get a weird feeling looking at this.", "Zed")
		$Notes3.play()
		await get_tree().create_timer($Notes3.stream.get_length()+ 3).timeout
		self.visible = false


func CityNotes4():
		_speaker.set("theme_override_colors/font_color", Note_Color)
		_dialogue.set("theme_override_colors/default", Child_Color)
		display_line("Don't Cross this bridge! | looks really unsafe.", "Zed")
		$Notes4.play()
		await get_tree().create_timer($Notes4.stream.get_length() + 3).timeout
		self.visible = false
