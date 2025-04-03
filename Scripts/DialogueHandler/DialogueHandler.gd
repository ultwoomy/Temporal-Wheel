extends RefCounted
class_name DialogueHandler
# To setup:
#	1. Create a new instance of DialogueHandler and assign it to a variable.
#	2. Assign JSON file path to "dialogueFilePath"
# Example of use:
#	1. Get dialogue data by calling "getDialogueData(...)", the parameter being any string one-indented in the JSON and on the left side (key).
#	2. Use the returned result of "getDialogueData(...)" as an argument for the "getFromSpecialKey(...)" method to get the text for a label's text to be assigned to.


#@ Enumerators
## These special keys are reserved keys used in the JSON file.
## Used as a shortcut to retrieve keys that are common in all dialogue JSON files.
enum SpecialKeys {
	TEXT,
	ANIMATION_NAME,
	BODY,
}


#@ Public Variables
## IN ORDER TO USE DialogueHandler, ASSIGN dialogueFilePath to a JSON file path!
var dialogueFilePath : String = "":  # Assign this to a dialogue JSON file path so that JSONReader can parse into a dictionary.
	set (value):
		dialogueFilePath = value
		_dialogueJSON = _jsonReader.loadJSONFile(dialogueFilePath)


#@ Private Variables
var _jsonReader : JSONReader = JSONReader.new()
var _dialogueJSON : Dictionary  # Should be set by setting dialogueFilePath.


#@ Public Methods
## The _dialogueJSON can contain multiple dialogue. In order to pick the correct dialogue in the JSON, give the name of the key.
## 	- KEY: The name of the dialogue needed to know to access the wanted dialogue lines.
##	- VALUE: Array of dictionaries; each dictionary have special keys like the "TEXT" key which is intended for a line of dialogue to display.
func getDialogueData(key : String) -> Array[Dictionary]:
	# Check if DialogueHandler has any dialogue given to it.
	if not _dialogueJSON:
		printerr("ERROR: No dialogue given to dialogue handler! Did you forget to give a JSON file path?")
		return []
	
	# Local variable
	var dialogueData : Array[Dictionary] = []
	
	# Find the key in the JSON and then get its item.
	if key in _dialogueJSON:  
		# Check to see if the value has proper dialogue formatting.
		# Should be an array that holds dictionaries, since each dictionary element is a new dialogue to display.
		if _dialogueJSON[key] is Array:  
			for element in _dialogueJSON[key]:  
				# The element is a Dictionary that holds info of each new dialogue, such as text and animation.
				if element is Dictionary:
					dialogueData.append(element)
	####
	## Rest of this is error checking.
	####
		else:
			printerr("ERROR: The value of the key, '", key, "', is not an array! Is the JSON formatting for dialogue correct?")
			return []
		return dialogueData
	else:
		printerr("ERROR: The given key, '", key, "', is not in the dialogue JSON!")
		return []


# Pass in a dialogueData's dialogue and a DialogueHandler.SpecialKeys arg to get a string value (if it was provided in the JSON).
func getFromSpecialKey(dialogue : Dictionary, specialKey : SpecialKeys) -> String:
	var specialKeyString : String = SpecialKeys.find_key(specialKey)  # Change the enumerator key element to a string.
	return dialogue[specialKeyString]
