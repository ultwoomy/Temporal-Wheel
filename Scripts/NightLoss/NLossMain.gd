extends AnimatedSprite2D
@export var zundaSprites : AnimatedSprite2D
@export var frontscreen : Sprite2D
@export var frontscreenLabel : Label
@export var zundaLabel : Label
@export var nextButton : Button
@export var frontScreenNext : Button
var _dialogueHandler : DialogueHandler = DialogueHandler.new()
var _dialogueLine : int = 0
var frames = 0

#@ Enumerators
enum Emotes {  # L.B: Have this enumerator be in the sprite for Packsmith. Please just create a sprite for Packsmith w/o the background.
	CONCERN,
	SHEEPISH,
	HAPPY,
	NEUTRAL
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_(delta):
	if frames > 0 and frames <= 200:
		frames += 1
		modulate = Color(frames/200,frames/200,frames/200)


func _introduce() -> void:
	# Visuals.
	frontscreenLabel.text = "Hey Wake Up."
	GVars._dialouge(frontscreenLabel,0,0.04)
	
	# Get Packsmith Introduction dialogue.
	_dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithIntroduction.json"
	var dialogue: Array[Dictionary] = _dialogueHandler.getDialogueData("introduction")
	
	# Listen for when nextButton is pressed to proceed with dialogue.
	if not nextButton.pressed.is_connected(_continueDialogue):
		nextButton.pressed.connect(_continueDialogue.bind(dialogue))
	
	# If Packsmith sigil unlocked, allow the Player to progress.
	if(GVars.sigilData.numberOfSigils[0]):
		nextButton.show()
		nextButton.text = "Perhaps this will\nchange your mind"


func _continueDialogue(dialogue: Array[Dictionary]) -> void:
	# Display dialogue.
	GVars._dialouge(zundaLabel,0,0.04)
	
	if _dialogueLine >= 0 and _dialogueLine < dialogue.size():
		# Change text to the dialogue text at index, _dialogueLine.
		zundaLabel.text = _dialogueHandler.getTextFromDialogue(dialogue[_dialogueLine])
		
		# Change face/background to the dialogue face at index, _dialogueLine. Matches with the Emotes enumerator.
		zundaSprites.frame = Emotes[_dialogueHandler.getFaceFromDialogue(dialogue[_dialogueLine])]
		
		# Change nextButton text to dialogue's BUTTON_TEXT, if it exists.
		if "BUTTON_TEXT" in dialogue[_dialogueLine]:
			nextButton.text = dialogue[_dialogueLine].BUTTON_TEXT
		else:
			nextButton.text = "Next"
		
		# Increment _dialogueLine to go to the next line of dialogue.
		_dialogueLine += 1
	else:
		zundaLabel.text = ""
		nextButton.hide()
