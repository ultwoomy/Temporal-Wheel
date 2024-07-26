extends PS_MenuState
class_name PS_MenuAugmentState


#@ Signals
signal augmentChanged


#@ Virtual Methods
func _enter() -> void:
	# Connect signals from PacksmithMenu class. Look at PacksmithMenuState.gd for more info.
	super._enter()
	
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
			packsmithMenu.changeState(PS_MenuInspectState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			# Clicking on augment button again when already in augment state will cancel show().
			packsmithMenu.changeState(PS_MenuPickState.new(packsmithMenu))
		packsmithMenu.upgradeButton:
			packsmithMenu.changeState(PS_MenuUpgradeState.new(packsmithMenu))
		packsmithMenu.automateButton:
			packsmithMenu.changeState(PS_MenuAutomateState.new(packsmithMenu))


func _onSigilButtonPressed(sigil: Sigil) -> void:
	# Change _dialogueHandler to have dialogue be about augmenting sigils.
	packsmithMenu._dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithAugment.json"
	
	# Ask for a particular topic from _dialogueHandler that will be said.
	var dialogue : Array[Dictionary] = packsmithMenu._dialogueHandler.getDialogueData(sigil.sigilName)
	GVars.sigilData.curSigilBuff = sigil.sigilBuffIndex
	
	# Exception. Maybe there is a cleaner way?
	if sigil.sigilName == "hell":
		if not GVars.currentChallenges:
			if not GVars.ifhell:
				dialogue = packsmithMenu._dialogueHandler.getDialogueData("hell")
			else:
				dialogue = packsmithMenu._dialogueHandler.getDialogueData("hellalt")
		else:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("hellcomplete")
			GVars.ifhell = true
			GVars.inContract = false
			GVars.currentChallenges = []
		GVars.sigilData.curSigilBuff = 5
	augmentChanged.emit()
	
	# Get a new TalkState using the correct dialogue.
	var newState : PS_MenuTalkState = PS_MenuTalkState.new(packsmithMenu, dialogue) 
	
	# Then change state to the new_state with the variables intact.
	packsmithMenu.changeState(newState)
