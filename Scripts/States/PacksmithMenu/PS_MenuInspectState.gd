extends PS_MenuState
class_name PS_MenuInspectState
# This state is transitioned into when the Inspect button from PacksmithMenu is pressed.
# Causes the selection menu to be shown, and then hidden when state is exited.


#@ Virtual Methods
func _enter() -> void:
	# Connect signals from PacksmithMenu class. Look at PacksmithMenuState.gd for more info.
	super._enter()
	
	# Show the inspect selection menu.
	packsmithMenu.selectionMenu.show()
	packsmithMenu.selectionMenu.display_sigils()
	
	# Listen for when a sigil is pressed.
	packsmithMenu.selectionMenu.sigil_button_pressed.connect(_on_sigil_button_pressed)


func _update(_delta: float) -> void:
	pass


func _exit() -> void:
	packsmithMenu.selectionMenu.hide()


#@ Private Methods
func _onButtonPressed(button: Button) -> void:
	match button:
		packsmithMenu.inspectButton:
			# Clicking on inspect button again when already in inspect state will cancel show().
			packsmithMenu.changeState(PS_MenuPickState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			packsmithMenu.changeState(PS_MenuAugmentState.new(packsmithMenu))
		packsmithMenu.upgradeButton:
			packsmithMenu.changeState(PS_MenuUpgradeState.new(packsmithMenu))
		packsmithMenu.automateButton:
			packsmithMenu.changeState(PS_MenuAutomateState.new(packsmithMenu))


func _on_sigil_button_pressed(sigil: SigilData.Sigils) -> void:
	# Change _dialogueHandler to have dialogue be about augmenting sigils.
	packsmithMenu._dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithInspect.json"
	
	# Ask for a particular topic from _dialogueHandler that will be said.
	var dialogue : Array[Dictionary]
	match sigil:
		SigilData.Sigils.PACKSMITH:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("packsmith")
		SigilData.Sigils.CANDLE:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("candle")
		SigilData.Sigils.ASCENSION:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("ascension")
		SigilData.Sigils.EMPTINESS:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("emptiness")
		SigilData.Sigils.RITUAL:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("ritual")
		SigilData.Sigils.HELL:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("hell")
	
	# Get a new TalkState using the correct dialogue.
	var newState : PS_MenuTalkState = PS_MenuTalkState.new(packsmithMenu, dialogue) 
	
	# Then change state to the new_state with the variables intact.
	packsmithMenu.changeState(newState)
