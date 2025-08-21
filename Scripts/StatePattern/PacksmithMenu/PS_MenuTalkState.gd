extends PS_MenuState
class_name PS_MenuTalkState


#@ Signals


#@ Private Variables
var _dialogueLine : int = 0
var _dialogueData : Array[Dictionary]


#@ Virtual Methods
# Override PacksmithMenuState's _init() function to also ask for dialogue.
func _init(_packsmithMenu : PacksmithMenu, dialogueData : Array[Dictionary]) -> void:
	packsmithMenu = _packsmithMenu
	_dialogueData = dialogueData


func _enter() -> void:
	# Listeners
	if not packsmithMenu.nextButton.pressed.is_connected(self._nextLine):
		packsmithMenu.nextButton.pressed.connect(self._nextLine)
	
	# Hiding/showing nodes.
#	GVars._dialouge(packsmithMenu.dialogueText,0,0.04)
	packsmithMenu.selectionMenu.hide()
	packsmithMenu.inspectButton.hide()
	packsmithMenu.augmentButton.hide()
	packsmithMenu.upgradeButton.hide()
	packsmithMenu.automateButton.hide()
	packsmithMenu.nextButton.show()
	packsmithMenu.dialogueText.show()
	
#	packsmithMenu.nextLin(_dialogueLine)
	_nextLine()


func _update(_delta : float) -> void:
	pass


func _exit() -> void:
	print("eg")
	packsmithMenu.dialogueText.text = ""
	packsmithMenu.packback.frame = packsmithMenu.Emotes.NORMAL
	_resetChoice()


#@ Private Methods
func _nextLine() -> void:
	# Check to see if _dialogueLine is out of bounds. If it is, dialogue is complete.
	if (_dialogueLine < 0) or (_dialogueLine >= _dialogueData.size()):
		packsmithMenu.changeState(PS_MenuPickState.new(packsmithMenu))
		return
	
	# Display dialogue.
	packsmithMenu.dialogueText.text = packsmithMenu._dialogueHandler.getFromSpecialKey(_dialogueData[_dialogueLine], DialogueHandler.SpecialKeys.TEXT)
	packsmithMenu.packback.frame = packsmithMenu.Emotes[packsmithMenu._dialogueHandler.getFromSpecialKey(_dialogueData[_dialogueLine], DialogueHandler.SpecialKeys.ANIMATION_NAME)]
	
	packsmithMenu.playedDialogueLine.emit()
	
	GVars._dialouge(packsmithMenu.dialogueText, 0, 0.03)
	
	# Increment counter.
	_dialogueLine += 1


func _resetChoice():
	packsmithMenu.dialogueText.text = ""
	packsmithMenu.packback.frame = 2
#	resetWindowVars()
	packsmithMenu.inspectButton.show()
	packsmithMenu.augmentButton.show()
	packsmithMenu.upgradeButton.show()
	
	if GVars.currentChallenges and (not GVars.hasChallengeActive(GVars.CHALLENGE_INCONGRUENT)) or GVars.ifhell:
		packsmithMenu.automateButton.show()
	packsmithMenu.nextButton.hide()
