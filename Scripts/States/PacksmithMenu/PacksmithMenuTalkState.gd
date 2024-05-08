extends PacksmithMenuState
class_name TalkState


#@ Enumerators


#@ Private Variables
var _dialogueLine: int


#@ Virtual Methods
func _enter() -> void:
	if _dialogueLine:
		GVars._dialouge(packsmithMenu.text,0,0.04)
		packsmithMenu.selectionMenu.hide()
		packsmithMenu.inspectButton.hide()
		packsmithMenu.augmentButton.hide()
		packsmithMenu.upgradeButton.hide()
		packsmithMenu.automateButton.hide()
		packsmithMenu.next.show()
		packsmithMenu.text.show()
		
		packsmithMenu.nextLin(_dialogueLine)
	else:
		printerr("ERROR: No dialogue line given for Packsmith! Did you set a dialogue line?")


func _update(_delta: float) -> void:
	pass


func _exit() -> void:
	pass


#@ Public Methods
func set_dialogue_line(index: int) -> void:
	# Probably have an error check to see if out of bounds
	_dialogueLine = index


#@ Private Methods
