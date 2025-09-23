extends Control


#dictonaries
#__________
#This Dic should be %cmd%:%What it do%
var cmdInformation = {
	"camera" : "Brings up Cameras sub-terminal menu you can look at Cryptids through",
	"exit" : "Leave the terminal View"
}

var inputText=""
var savedInput=""
var outputCleaned = false
var filePath = "CZ:/" #at some point implement this and make it right

#make an array for inputText
#Create some signals for the cameras 
#Frequency changes
#so the cameras can be used in other terminal instences


#make an array for input and output and append information OR
#make the input run through a dictonary to verify if function exists, then use function, upload to output

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		enterKeyPressed()
	pass


func enterKeyPressed() -> void:
		savedInput = $Input.text.strip_edges()
		$Input.text=""
		#this gets rid of everything in output, each time enter key is pressed
		if !outputCleaned:
			if $Output.text != "OUTPUT":
				$Output.text = ""
			outputCleaned=true
			$Output.text += "> " + savedInput+"\n"
		if checkCMD(savedInput):
			var information = cmdInformation[savedInput]
			$Output.text += information + "\n" #temp information to output
			#TODO right here implement running the function, or like implement a return function
		else:
			$Output.text += "Unknown command: " + savedInput + "\n" #change to break or something

		print("Enter Pressed: " + savedInput)
	
	
	
	#

func checkCMD(input) -> bool:
	#check if command exists in dic
	return cmdInformation.has(input)



func _on_text_edit_caret_changed() -> void:
	
	print("Caret Moved?")
	pass # Replace with function body.
