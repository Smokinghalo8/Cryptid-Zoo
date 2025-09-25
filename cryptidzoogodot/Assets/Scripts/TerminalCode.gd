extends Control


#dictonaries
#__________
#This Dic should be %cmd%:%What it do%
var cmdInformation = {
	"help" : "Provides more information about certain commands",
	"camera" : "Brings up Cameras sub-terminal menu you can look at Cryptids through",
	"exit" : "Leave the terminal View"
}

var information =""
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
		var splitInput = savedInput.split(" ")
		#TODO check if there is more than 2 array values, if so then get rid of the third
		$Input.text=""
		#this gets rid of everything in output, each time enter key is pressed
		if !outputCleaned:
			if $Output.text != "OUTPUT":
				$Output.text = ""
			outputCleaned=true
			$Output.text += "> " + savedInput+"\n"
		if checkCMD(savedInput):
			if !runCommand(splitInput[0], splitInput[1]):
				print("Command failed\nsplitInput[0]: "+ splitInput[0] +"\nsplitInput[1]: "+splitInput[1])
			pass
			
			#var information = cmdInformation[savedInput]#returns the information block from input
			#$Output.text += information + "\n" #temp information to output
			#TODO right here implement running the function, or like implement a return function
		else:
			$Output.text += "Unknown command: " + savedInput + "\n" #change to break or something

		print("Enter Pressed: " + savedInput)
	
	
	
	#

func checkCMD(input) -> bool:
	#check if command exists in dic
	return cmdInformation.has(input)


func runCommand(command, parameter) -> bool:
	
	match command:
		"help":
			information = cmdInformation[parameter]
			$Output.text=information
		_:
			print("Default")
	
	return false#meaning the commandFailed
	


func _on_text_edit_caret_changed() -> void:
	
	print("Caret Moved?")
	pass # Replace with function body.
