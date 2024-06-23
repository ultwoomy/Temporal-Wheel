extends PS_MenuState
class_name PS_MenuPickState


#@ Virtual Methods
func _enter() -> void:
	# Connect signals from PacksmithMenu class. Look at PacksmithMenuState.gd for more info.
	super._enter()


func _update(_delta: float) -> void:
	pass


func _exit() -> void:
	pass


#@ Private Methods
func _onButtonPressed(button: Button) -> void:
	match button:
		packsmithMenu.inspectButton:
			packsmithMenu.changeState(PS_MenuInspectState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			packsmithMenu.changeState(PS_MenuAugmentState.new(packsmithMenu))
		packsmithMenu.upgradeButton:
			packsmithMenu.changeState(PS_MenuUpgradeState.new(packsmithMenu))
		packsmithMenu.automateButton:
			packsmithMenu.changeState(PS_MenuAutomateState.new(packsmithMenu))
