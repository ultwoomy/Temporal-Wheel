extends State
class_name PacksmithMenuState


#@ Constants


#@ Global Variables
# Use this to be able to reference the PacksmithMenu.
var packsmithMenu : PacksmithMenu 


#@ Functions
# Requires PacksmithMenuStates to be initialized with a reference to PacksmithMenu.
func _init(_packsmithMenu : PacksmithMenu) -> void:
	packsmithMenu = _packsmithMenu

