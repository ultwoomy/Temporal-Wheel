extends PacksmithMenuState
class_name TalkState

#@ Enumerators


#@ Private Variables
var _dialogueLine : int = 0
var _dialogue : Array[Dictionary]


#@ Virtual Methods
# Override PacksmithMenuState's _init() function to also ask for dialogue.
func _init(_packsmithMenu : PacksmithMenu, dialogue : Array[Dictionary]) -> void:
	packsmithMenu = _packsmithMenu
	_dialogue = dialogue


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
	if (_dialogueLine < 0) or (_dialogueLine >= _dialogue.size()):
		packsmithMenu.changeState(PickState.new(packsmithMenu))
		return
	
	# Display dialogue.
	packsmithMenu.dialogueText.text = packsmithMenu._dialogueHandler.getTextFromDialogue(_dialogue[_dialogueLine])
	packsmithMenu.packback.frame = packsmithMenu.Emotes[packsmithMenu._dialogueHandler.getFaceFromDialogue(_dialogue[_dialogueLine])]
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
	if(GVars.hellChallengeNerf > 0) or (GVars.ifhell):
		packsmithMenu.automateButton.show()
	packsmithMenu.nextButton.hide()
