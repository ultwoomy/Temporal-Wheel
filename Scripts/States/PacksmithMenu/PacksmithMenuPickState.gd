extends PacksmithMenuState
class_name PickState


#@ Virtual Methods
func _enter() -> void:
	# Connect signals from PacksmithMenu class.
	if not packsmithMenu.inspectButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.inspectButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.inspectButton))
	if not packsmithMenu.augmentButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.augmentButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.augmentButton))
	if not packsmithMenu.upgradeButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.upgradeButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.upgradeButton))
	if not packsmithMenu.automateButton.pressed.is_connected(_onButtonPressed):
		packsmithMenu.automateButton.pressed.connect(_onButtonPressed.bind(packsmithMenu.automateButton))


func _update(delta: float) -> void:
	pass


func _exit() -> void:
	pass


#@ Private Methods
func _onButtonPressed(button: Button) -> void:
	match button:
		packsmithMenu.inspectButton:
			packsmithMenu.changeState(InspectState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			pass
		packsmithMenu.upgradeButton:
			packsmithMenu.changeState(UpgradeState.new(packsmithMenu))
		packsmithMenu.automateButton:
			pass
