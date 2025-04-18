extends Control
class_name VoidSpaceTutorialBox


#@ Signals
signal kbity_up


#@ Constants
const DIALOGUE_INTRODUCTION_KEY : String = "introduction"
const DIALOGUE_KBITY_KEY : String = "kbity"


#@ Export Variables


#@ Public Variables
var dialogueData : Array[Dictionary]


#@ Private Variables
var _dialogueHandler : DialogueHandler = DialogueHandler.new()
var _dialogueIndex : int = 0


#@ Onready Variables
@onready var dialogueText : Label = $DialogueText
@onready var bunniesSprite : AnimatedSprite2D = $Bunnies
@onready var nextButton : Button = $NextButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Get dialogue JSON file.
	_dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/VoidSpaceStop/VoidSpaceTutorialBox.json"
	
	# Only shows the dialouge box if its the players first time coming here
	if GVars.ifFirstVoid:
		dialogueText.text = "Welcome to the bus stop!"
		dialogueData = _dialogueHandler.getDialogueData(DIALOGUE_INTRODUCTION_KEY)
		get_tree().paused = true
		show()
	elif GVars.kbityData.kbityLevel == 1:
		# TODO: Note that the the first message shows first still.
		# Can be fixed by having the first message display by doing what is done in _buttonPressed().
		kbityTime()
	else:
		hide()
	
	nextButton.pressed.connect(self._buttonPressed)
	
	GVars._dialouge(dialogueText, 0, 0.02)
	
	# L.B: This doesn't do anything. Don't use signals when you can just call the method.
	self.kbity_up.connect(self.kbityTime)


#@ Public Methods
# L.B: Don't know what to do with this quite yet.
func kbityTime():
	dialogueData = _dialogueHandler.getDialogueData(DIALOGUE_KBITY_KEY)
	get_tree().paused = true  # TODO: Use a signal
	show()


#@ Private Methods
func _buttonPressed():
	GVars._dialouge(dialogueText, 0, 0.03)
	
	if _dialogueIndex < dialogueData.size() and _dialogueIndex >= 0:
		dialogueText.text = _dialogueHandler.getFromSpecialKey(dialogueData[_dialogueIndex], DialogueHandler.SpecialKeys.TEXT)
		bunniesSprite.animation = _dialogueHandler.getFromSpecialKey(dialogueData[_dialogueIndex], DialogueHandler.SpecialKeys.ANIMATION_NAME)
	else:
		hide()
		GVars.ifFirstVoid = false
		get_tree().paused = false
	_dialogueIndex += 1
