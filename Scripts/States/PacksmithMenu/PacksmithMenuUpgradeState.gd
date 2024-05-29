extends PacksmithMenuState
class_name UpgradeState
# This state is transitioned into when the Inspect button from PacksmithMenu is pressed.
# Causes the selection menu to be shown, and then hidden when state is exited.


#@ Virtual Methods
func _enter() -> void:
	# Connect signals from PacksmithMenu class. Look at PacksmithMenuState.gd for more info.
	super._enter()
	
	# Show the inspect selection menu.
	packsmithMenu.upgradeMenu.show()
#	packsmithMenu.upgradeMenu.display_sigils()


func _update(_delta: float) -> void:
	pass


func _exit() -> void:
	packsmithMenu.upgradeMenu.hide()


#@ Private Methods
func _onButtonPressed(button: Button) -> void:
	match button:
		packsmithMenu.inspectButton:
			packsmithMenu.changeState(InspectState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			packsmithMenu.changeState(AugmentState.new(packsmithMenu))
		packsmithMenu.upgradeButton:
			# Clicking on upgrade button again when already in upgrade state will cancel show().
			packsmithMenu.changeState(PickState.new(packsmithMenu))
		packsmithMenu.automateButton:
			packsmithMenu.changeState(AutomateState.new(packsmithMenu))
