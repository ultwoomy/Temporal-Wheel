class_name DialogueHandler


#@ Public Variables
var dialogueFilePath : String = "": # Assign this to a dialogue JSON file path so that JSONReader can parse into a dictionary.
	set (value):
		dialogueFilePath = value
		_dialogueJSON = _jsonReader.loadJSONFile(dialogueFilePath)


#@ Private Variables
var _jsonReader : JSONReader = JSONReader.new()
var _dialogueJSON : Dictionary


#@ Public Methods
# L.B: Dialogue JSONs should have a KEY with its VALUE assigned to an array of dictionaries.
# I am thus classifying this as "DialogueData", which this method is getting.
# 	- KEY: topic of conversation; name of the dialogue, need to know it to access the dialogue lines.
#	- VALUE: array of dictionaries - things for speaker to say; each dictionary has a "TEXT" key and a "FACE" key.
func getDialogueData(key: String) -> Array[Dictionary]:
	# Check if DialogueHandler has any dialogue given to it.
	if not _dialogueJSON:
		printerr("ERROR: No dialogue given to dialogue handler!")
		return []
	
	# Local variable
	var dialogueData : Array[Dictionary] = []
	
	# Find the key in the JSON, if it exists and it's an array, retrieve the dictionaries that 
	# may be inside it. Then return all of the dictionaries as an array of dictionaries.
	if key in _dialogueJSON:
		if _dialogueJSON[key] is Array:
			for element in _dialogueJSON[key]:
				if element is Dictionary:
					dialogueData.append(element)
		else:
			printerr("ERROR: The value of the key, '", key, "', is not an array! Is the JSON formatting for dialogue correct?")
			return []
		return dialogueData
	else:
		printerr("ERROR: The given key, '", key, "', is not in the dialogue JSON!")
		return []


func getTextFromDialogue(dialogue: Dictionary) -> String:
	if "TEXT" in dialogue:
		return dialogue["TEXT"]
	else:
		printerr("ERROR: Provided dictionary does not have a key for text! Unable to get dialogue text.")
		return ""


func getFaceFromDialogue(dialogue: Dictionary) -> String:
	if "FACE" in dialogue:
		return dialogue["FACE"]
	else:
		printerr("ERROR: Provided dictionary does not have a key for face! Unable to get dialogue face.")
		return ""


#@ Private Methods

