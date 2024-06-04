extends PacksmithMenuState
class_name AugmentState
signal changedAugment

#@ Virtual Methods
func _enter() -> void:
	# Connect signals from PacksmithMenu class. Look at PacksmithMenuState.gd for more info.
	super._enter()
	
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
			packsmithMenu.changeState(InspectState.new(packsmithMenu))
		packsmithMenu.augmentButton:
			# Clicking on augment button again when already in augment state will cancel show().
			packsmithMenu.changeState(PickState.new(packsmithMenu))
		packsmithMenu.upgradeButton:
			packsmithMenu.changeState(UpgradeState.new(packsmithMenu))
		packsmithMenu.automateButton:
			packsmithMenu.changeState(AutomateState.new(packsmithMenu))


func _on_sigil_button_pressed(sigil: SigilData.Sigils) -> void:
	# Change _dialogueHandler to have dialogue be about augmenting sigils.
	packsmithMenu._dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithAugment.json"
	
	# Ask for a particular topic from _dialogueHandler that will be said.
	var dialogue : Array[Dictionary]
	match sigil:
		SigilData.Sigils.PACKSMITH:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("packsmith")
			GVars.sigilData.curSigilBuff = 0
			emit_signal("changedAugment")
		SigilData.Sigils.CANDLE:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("candle")
			GVars.sigilData.curSigilBuff = 1
			emit_signal("changedAugment")
		SigilData.Sigils.ASCENSION:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("ascension")
			GVars.sigilData.curSigilBuff = 2
			emit_signal("changedAugment")
		SigilData.Sigils.EMPTINESS:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("emptiness")
			GVars.sigilData.curSigilBuff = 3
			emit_signal("changedAugment")
		SigilData.Sigils.RITUAL:
			dialogue = packsmithMenu._dialogueHandler.getDialogueData("ritual")
			GVars.sigilData.curSigilBuff = 4
			emit_signal("changedAugment")
		SigilData.Sigils.HELL:
			if(GVars.hellChallengeNerf < 0):
				if(!GVars.ifhell):
					dialogue = packsmithMenu._dialogueHandler.getDialogueData("hell")
				else:
					dialogue = packsmithMenu._dialogueHandler.getDialogueData("hellalt")
			else:
				dialogue = packsmithMenu._dialogueHandler.getDialogueData("hellcomplete")
				GVars.ifhell = true
				GVars.inContract = false
				GVars.hellChallengeNerf = -1
			GVars.sigilData.curSigilBuff = 5
			emit_signal("changedAugment")
	
	# Get a new TalkState using the correct dialogue.
	var newState : TalkState = TalkState.new(packsmithMenu, dialogue) 
	
	# Then change state to the new_state with the variables intact.
	packsmithMenu.changeState(newState)
