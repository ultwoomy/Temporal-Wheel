extends Control


#@ Signals
signal dialogueCompleted


#@ Enumerators
enum ZUNDA_FACES {
	SERENE,
	SMUG,
	CHATTING,
	APPALLED,
}
enum ZUNDA_BODY {
	FINGERGUNS,
	HAND_ON_HIPS,
	DIRECTING,
}


#@ Constants
const ZUNDA_DIALOGUE_FILEPATH : String = "res://JSON/Dialogue/Zunda/ZundaIntroduction.json"


#@ Public Variables
var dialogueData : Array[Dictionary]
var dialogueLine : int = 0


#@ Private Variables
var _dialogueHandler : DialogueHandler = DialogueHandler.new()


#@ Onready Variables
@onready var zundaBodySprite : AnimatedSprite2D = $ZundaBody
@onready var zundaFaceSprite : AnimatedSprite2D = $ZundaFace
@onready var dialogueBox : Sprite2D = $DialogueBox
@onready var nextButton : Button = $NextButton
@onready var dialogueLabel : Label = $DialogueLabel


#@ Virtual Methods
func _ready() -> void:
	_dialogueHandler.dialogueFilePath = ZUNDA_DIALOGUE_FILEPATH
	dialogueData = _dialogueHandler.getDialogueData("introduction")
	dialogueLabel.text = _dialogueHandler.getTextFromDialogue(dialogueData[dialogueLine])


#@ Private Methods
func _onNextPressed():
	dialogueLine += 1
	if dialogueLine < dialogueData.size():
		GVars._dialouge(dialogueLabel, 0, 0.02)
		dialogueLabel.text = _dialogueHandler.getTextFromDialogue(dialogueData[dialogueLine])
		zundaBodySprite.frame = ZUNDA_BODY[_dialogueHandler.getBodyFromDialogue(dialogueData[dialogueLine])]
		zundaFaceSprite.frame = ZUNDA_FACES[_dialogueHandler.getFaceFromDialogue(dialogueData[dialogueLine])]
	else:
		self.hide()
		dialogueCompleted.emit()
		GVars.ifFirstHell = false
