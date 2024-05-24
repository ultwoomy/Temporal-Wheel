class_name JSONReader


# L.B: Here are some notes on how this exactly works. Should be simple enough to understand.
# Load a .json file from the path provided and return the contents of it (parsed .json files are dictionaries).
func loadJSONFile(filePath: String) -> Dictionary:
	# Checks first if the file path is valid.
	if FileAccess.file_exists(filePath):
		# Open up the .json file and read its contents thanks to the "FileAccess" class and methods.
		var jsonFile : FileAccess = FileAccess.open(filePath, FileAccess.READ)
		
		# Parse the contents of the .json file to be usable in Godot using the "JSON" class Godot provides.
		var parsedResult = JSON.parse_string(jsonFile.get_as_text())
		
		# The parsing of the JSON file should get us a Godot dictionary.
		if parsedResult is Dictionary:
			return parsedResult
		else:
			printerr("ERROR: failed to read JSON file!")
	else:
		printerr("ERROR: file does not exist at path \"", filePath, "\"!")
	# If encountered errors, return an EMPTY dictionary instead.
	return {}
