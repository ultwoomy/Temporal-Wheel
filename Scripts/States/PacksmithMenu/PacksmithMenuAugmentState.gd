extends PacksmithMenuState
class_name AugmentState


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
			# L.B: Reminder for later for the correct dialogue line.
#			elif(n == 6):
#			if(GVars.hellChallengeNerf < 0):
#				if(!GVars.ifhell):
#					nextLin(11)
#					sigilToActivate = 6
#				else:
#					nextLin(13)
#					sigilToActivate = 6
#			else:
#				nextLin(12)
#				sigilToActivate = 6
#				GVars.ifhell = true
#				GVars.inContract = false
#				GVars.hellChallengeNerf = -1
	
	# Get a new TalkState using the correct dialogue.
	var newState : TalkState = TalkState.new(packsmithMenu, dialogue) 
	
	# Then change state to the new_state with the variables intact.
	packsmithMenu.changeState(newState)
