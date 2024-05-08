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
	# Create a new TalkState state to have values passed to it.
	var new_state: TalkState = TalkState.new(packsmithMenu)
	
	match sigil:
		SigilData.Sigils.PACKSMITH:
			new_state.set_dialogue_line(6)
		SigilData.Sigils.CANDLE:
			new_state.set_dialogue_line(7)
		SigilData.Sigils.ASCENSION:
			new_state.set_dialogue_line(8)
		SigilData.Sigils.EMPTINESS:
			new_state.set_dialogue_line(9)
		SigilData.Sigils.RITUAL:
			new_state.set_dialogue_line(10)
		SigilData.Sigils.HELL:
			new_state.set_dialogue_line(11)
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
	
	# Then change state to the new_state with the variables intact.
	packsmithMenu.changeState(new_state)
