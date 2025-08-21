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
	packsmithMenu.selectionMenu.displaySigils()
	
	# Listen for when a sigil is pressed.
	packsmithMenu.selectionMenu.sigilButtonPressed.connect(_onSigilButtonPressed)


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


func _onSigilButtonPressed(sigil: Sigil) -> void:
	# Change _dialogueHandler to have dialogue be about augmenting sigils.
	packsmithMenu._dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithInspect.json"
	
	# Error checking.
	if not sigil:
		printerr("ERROR: Sigil selected does not have a sigil resource attached! Unable to inspect sigil!")
		return
	if not sigil.sigilName:
		printerr("ERROR: Sigil selected does not have a name! Unable to inspect sigil!")
		return
	
	# Ask for a particular topic from _dialogueHandler that will be said.
	var dialogueData : Array[Dictionary] = packsmithMenu._dialogueHandler.getDialogueData(sigil.sigilName)
	
	# Signal if anything uses this dialogue.
	packsmithMenu.receivedDialogue.emit(dialogueData)
	
	# Get a new TalkState using the correct dialogue.
	var newState : PS_MenuTalkState = PS_MenuTalkState.new(packsmithMenu, dialogueData)
	
	# Then change state to the new_state with the variables intact.
	packsmithMenu.changeState(newState)
