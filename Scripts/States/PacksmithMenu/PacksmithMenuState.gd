extends State
class_name PacksmithMenuState


#@ Constants


#@ Global Variables
# Use this to be able to reference the PacksmithMenu.
var packsmithMenu : PacksmithMenu 


#@ Virtual Methods
# Requires PacksmithMenuStates to be initialized with a reference to PacksmithMenu.
func _init(_packsmithMenu : PacksmithMenu) -> void:
	packsmithMenu = _packsmithMenu


# Derived classes *SHOULD* call super._enter().
func _enter() -> void:
	# Listen to button press signals coming from Packsmith.
	if not packsmithMenu.inspectButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.inspectButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.inspectButton))
	if not packsmithMenu.augmentButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.augmentButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.augmentButton))
	if not packsmithMenu.upgradeButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.upgradeButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.upgradeButton))
	if not packsmithMenu.automateButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.automateButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.automateButton))


func _onButtonPressed(_button: Button) -> void:
	pass
