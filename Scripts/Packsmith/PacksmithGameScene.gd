extends GameScene
class_name PacksmithGameScene


#@ Enumerators
enum Emotes {  # L.B: Have this enumerator be in the sprite for Packsmith. Please just create a sprite for Packsmith w/o the background.
	HIDDEN,
	HIDDENEYEBROW,
	NORMAL,
	TALKING,
	EYEBROW,
	CONCERN,
}


#@ Export Variables


#@ Public Variables


#@ Private Variables
var _dialogueHandler : DialogueHandler = DialogueHandler.new()
var _dialogueLine : int = 0


#@ Onready Variables
@onready var packsmithBackground : AnimatedSprite2D = $PacksmithBackground
@onready var packsmith : Packsmith = $Packsmith
@onready var sigilDisplay : AnimatedSprite2D = $SigilDisplay
@onready var nextButton : Button = $NextButton
@onready var backButton : Button = $BackButton
@onready var dialogueText : Label = $DialogueText
@onready var menu : PacksmithMenu = $PacksmithMenu


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Visuals.
	packsmithBackground.frame = 2
	nextButton.hide()
	menu.hide()
	
	# Listening to signals.
	backButton.pressed.connect(self._onBackButtonPressed)
	menu.receivedDialogue.connect(packsmith.getFaceExpressionsFromDialogueData)
	menu.playedDialogueLine.connect(packsmith.playNextFaceExpression)
	menu.completedDialogue.connect(packsmith.expressEmotion)
	
	# Displays the sigil on the anvil that is currently augmented.
	_setSigilDisplay()
	
	# Introduce Packsmith if haven't yet.
	if GVars.ifFirstPack:
		_introduce()
	else:
		menu.show()


#@ Public Methods
#Doing it by frame for now since I tried using signals and it didn't really work for some reason
func _process(_delta):
	_setSigilDisplay()


#@ Private Methods
func _setSigilDisplay():
	if GVars.sigilData.currentAugmentedSigil:
		sigilDisplay.animation = GVars.sigilData.currentAugmentedSigil.sigilName
		sigilDisplay.show()
	else:
		sigilDisplay.animation = "packsmith"
		sigilDisplay.hide()


func _introduce() -> void:
	# Visuals.
	packsmithBackground.frame = 1
	dialogueText.text = "We're Closed."
	GVars._dialouge(dialogueText,0,0.04)
	
	# Get Packsmith Introduction dialogue.
	_dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithIntroduction.json"
	var dialogue: Array[Dictionary] = _dialogueHandler.getDialogueData("introduction")
	
	# Listen for when nextButton is pressed to proceed with dialogue.
	if not nextButton.pressed.is_connected(_continueDialogue):
		nextButton.pressed.connect(_continueDialogue.bind(dialogue))
	
	# If Packsmith sigil unlocked, allow the Player to progress.
	if GVars.SIGIL_PACKSMITH in GVars.sigilData.acquiredSigils:
		nextButton.show()
		nextButton.text = "Perhaps this will\nchange your mind"


func _continueDialogue(dialogue: Array[Dictionary]) -> void:
	# Display dialogue.
	GVars._dialouge(dialogueText,0,0.04)
	
	if _dialogueLine >= 0 and _dialogueLine < dialogue.size():
		# Change text to the dialogue text at index, _dialogueLine.
		dialogueText.text = _dialogueHandler.getFromSpecialKey(dialogue[_dialogueLine], DialogueHandler.SpecialKeys.TEXT)

		# Change face/background to the dialogue face at index, _dialogueLine. Matches with the Emotes enumerator.
		packsmithBackground.frame = Emotes[_dialogueHandler.getFromSpecialKey(dialogue[_dialogueLine], DialogueHandler.SpecialKeys.ANIMATION_NAME)]
		
		# TODO
		# TODO: Figure out how to replace the old one and do this.
		# TODO
		packsmith.headSprites.animation = Emotes[_dialogueHandler.getFromSpecialKey(dialogue[_dialogueLine], DialogueHandler.SpecialKeys.ANIMATION_NAME)].to_lower()
		#packsmith.expressEmotion()
		
		# Change nextButton text to dialogue's BUTTON_TEXT, if it exists.
		if "BUTTON_TEXT" in dialogue[_dialogueLine]:
			nextButton.text = dialogue[_dialogueLine].BUTTON_TEXT
		else:
			nextButton.text = "Next"
		
		# Increment _dialogueLine to go to the next line of dialogue.
		_dialogueLine += 1
	else:
		dialogueText.text = ""
		menu.show()
		nextButton.hide()
		GVars.ifFirstPack = false


func _onBackButtonPressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.RUSTSPACE_OUTSIDE)
