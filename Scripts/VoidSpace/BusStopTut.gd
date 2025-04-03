extends Container


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
var _dialogueLine : int = 0


#@ Onready Variables
@onready var dialogueBox : Label = $DialogueBox
@onready var bunniesSprite : AnimatedSprite2D = $Bunnies
@onready var nextButton : Button = $NextButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Get dialogue JSON file.
	_dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/VoidSpaceStop/VoidSpaceTutorialBox.json"
	
	# Only shows the dialouge box if its the players first time coming here
	if GVars.ifFirstVoid:
		dialogueData = _dialogueHandler.getDialogueData(DIALOGUE_INTRODUCTION_KEY)
		get_tree().paused = true
		show()
	else:
		hide()
	
	dialogueBox.position = Vector2(300,300)
	dialogueBox.text = "Welcome to the bus stop!"
	dialogueBox.size = Vector2(400,200)
	
	nextButton.size = Vector2(100,100)
	nextButton.position = Vector2(650,400)
	nextButton.text = "Next"
	nextButton.expand_icon = true
	nextButton.pressed.connect(self._buttonPressed)
	
	GVars._dialouge(dialogueBox,0,0.02)
	self.kbity_up.connect(self.kbityTime)


#@ Public Methods
# L.B: Don't know what to do with this quite yet.
func kbityTime():
	if(GVars.kbityData.kbityLevel == 1):
		dialogueData = _dialogueHandler.getDialogueData(DIALOGUE_KBITY_KEY)
		get_tree().paused = true  # TODO: Use a signal
		show()


#@ Private Methods
func _buttonPressed():
	GVars._dialouge(dialogueBox, 0, 0.03)
	
	if _dialogueLine < dialogueData.size() and _dialogueLine >= 0:
		dialogueBox.text = _dialogueHandler.getFromSpecialKey(dialogueData[_dialogueLine], DialogueHandler.SpecialKeys.TEXT)
		bunniesSprite.animation = _dialogueHandler.getFromSpecialKey(dialogueData[_dialogueLine], DialogueHandler.SpecialKeys.ANIMATION_NAME)
	else:
		hide()
		GVars.ifFirstVoid = false
		get_tree().paused = false
	_dialogueLine += 1
