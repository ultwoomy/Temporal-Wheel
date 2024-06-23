extends PS_MenuState
class_name PS_MenuUpgradeState
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
			packsmithMenu.changeState(PS_MenuInspectState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			packsmithMenu.changeState(PS_MenuAugmentState.new(packsmithMenu))
		packsmithMenu.upgradeButton:
			# Clicking on upgrade button again when already in upgrade state will cancel show().
			packsmithMenu.changeState(PS_MenuPickState.new(packsmithMenu))
		packsmithMenu.automateButton:
			packsmithMenu.changeState(PS_MenuAutomateState.new(packsmithMenu))
