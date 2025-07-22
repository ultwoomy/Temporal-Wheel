extends Control
class_name TutorialBunny


#@ Signals


#@ Enumerators
enum Stage {
	HAS_NOT_CLICKED_GROW_YET,  # Possibility 0: Player has NOT clicked on Grow button.
	HAS_NOT_GAINED_LEVELS_IN_SIZE_SINCE_TOGGLED,  # Possibility 1: Player has Grow button toggled on but does NOT have any wheel size.
	HAS_NOT_GAINED_LEVELS_BEFORE_TOGGLING_OFF,  # Possibility 2: Player has Grow button toggled OFF *and* does NOT have any wheel size.
	HAS_GAINED_LEVELS_IN_SIZE,  # Possibility 3: Player has some wheel size but no density.
	ABLE_TO_CONDENSE,  # Possibility 4: Player has enough to condense.
	ABLE_TO_TRAVEL,
	ERROR
}


#@ Constants
const DIALOGUE_JSON_FILE_PATH : String = "res://JSON/Dialogue/TutorialBunny/TutorialBunnyWheelSpaceIntro.json"
const DIALOGUE_INTRO_KEY : String = "intro"
const DIALOGUE_INFO_KEY : String = "grow_info"
const DIALOGUE_CONDENSE_INFO_KEY : String = "condense_info"
const DIALOGUE_GROW_TOGGLED_ON_KEY : String = "grow_toggled_on"
const DIALOGUE_GROW_TOGGLED_OFF_KEY : String = "grow_toggled_off"
const DIALOGUE_TRAVEL_KEY : String = "departure"

const START_POSITION : Vector2 = Vector2(769, 269)  # Position for the root node, NOT the sprite.
const END_POSITION : Vector2 = Vector2(650,390)
const DURATION_OF_TRAVEL : float = 2.0  # Time it takes for the bunny to travel to end position.


#@ Public Variables
var dialogueHandler : DialogueHandler = DialogueHandler.new()
var dialogueLineIndex : int = 0
var dialogueData : Array[Dictionary]
var currentDialogueStage : Stage


#@ Onready Variables
@onready var bunnySprite : Sprite2D = $BunnySprite
@onready var bubbleButton : TextureButton = $TextBubble
@onready var bubbleLabel : Label = $Label

@onready var tween : Tween


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	bunnySprite.hide()
	bubbleButton.hide()
	bubbleLabel.hide()


#@ Public Methods
func introduceSelf():
	bunnySprite.show()
	
	# Move into position for the Player to see.
	tween = create_tween()  # When using tweens, best practice is to create and then delete after finished. Or you'll get errors (started with no Tweeners).
	tween.tween_property(self, "position", END_POSITION, DURATION_OF_TRAVEL)
	await tween.finished
	tween.kill()
	
	start()


func start() -> void:
	# Display text bubble for Tutorial Bunny.
	bubbleLabel.show()
	bubbleButton.show()
	
	# Listen for signals.
	bubbleButton.pressed.connect(_onTextBubblePressed)
	GVars.spinData.currentSuckSizeChanged.connect(_onWheelGrowing)
	
	# Display first text based on stage of Grow state (which depends on Global variables).
	dialogueHandler.dialogueFilePath = DIALOGUE_JSON_FILE_PATH
	_resetAndDisplayDialogue()


#@ Private Methods
func _resetAndDisplayDialogue() -> void:
	# If unsure of the stage the Player is at in the tutorial, find the Stage.
	if not currentDialogueStage:
		currentDialogueStage = _findStage()
	else:
		var stage : Stage = _findStage()
		if currentDialogueStage != stage:
			currentDialogueStage = stage
			dialogueLineIndex = 0
	
	# Set the dialogue to the correct one that would make sense for the Player to be on.
	var dialogueKey : String = _getDialogueKeyFromStage(currentDialogueStage)
	dialogueData = dialogueHandler.getDialogueData(dialogueKey)
	
	if dialogueData:
		if dialogueLineIndex < dialogueData.size():
			bubbleLabel.text = dialogueHandler.getFromSpecialKey(dialogueData[dialogueLineIndex], DialogueHandler.SpecialKeys.TEXT)


func _findStage() -> Stage:
	# Local variables for better understanding.
	var hasToggledGrowButton : bool = GVars.spinData.sizeToggle
	var hasWheelSize : bool = GVars.spinData.size > 1
	var hasDensityRequirement : bool = GVars.spinData.size >= GVars.spinData.densTresh + 1
	var hasWheelDensity : bool = GVars.spinData.density > 1
	var hasWheelSizeProgress : bool = GVars.spinData.curSucSize > 0
	
	# Stage 0: Player has NOT clicked on Grow button.
	if not hasToggledGrowButton and not hasWheelSize and not hasWheelDensity:
		return Stage.HAS_NOT_CLICKED_GROW_YET
	# Stage 1: Player has Grow button toggled ON but does NOT have any wheel size or any progress to wheel size.
	elif hasToggledGrowButton and not hasWheelSize and not hasWheelSizeProgress and not hasWheelDensity:
		return Stage.HAS_NOT_GAINED_LEVELS_IN_SIZE_SINCE_TOGGLED
	# Stage 2: Player has Grow button toggled OFF *and* does NOT have any wheel size.
	elif not hasToggledGrowButton and not hasWheelSize and not hasWheelDensity:
		return Stage.HAS_NOT_GAINED_LEVELS_BEFORE_TOGGLING_OFF
	# Stage 3: Player has some wheel size but no density.
	elif (hasWheelSize or hasWheelSizeProgress) and not hasWheelDensity and not hasDensityRequirement:
		return Stage.HAS_GAINED_LEVELS_IN_SIZE
	# Stage 4: Player has enough to condense.
	elif hasDensityRequirement and not hasWheelDensity:
		return Stage.ABLE_TO_CONDENSE
	# Stage 5: Player has condensed.
	elif hasWheelDensity:
		return Stage.ABLE_TO_TRAVEL
	else:
		return Stage.ERROR


func _getDialogueKeyFromStage(stage : Stage) -> String:
	var result : String
	match stage:
		Stage.HAS_NOT_CLICKED_GROW_YET: return DIALOGUE_INTRO_KEY
		Stage.HAS_NOT_GAINED_LEVELS_IN_SIZE_SINCE_TOGGLED: return DIALOGUE_GROW_TOGGLED_ON_KEY
		Stage.HAS_NOT_GAINED_LEVELS_BEFORE_TOGGLING_OFF: return DIALOGUE_GROW_TOGGLED_OFF_KEY
		Stage.HAS_GAINED_LEVELS_IN_SIZE: return DIALOGUE_INFO_KEY
		Stage.ABLE_TO_CONDENSE: return DIALOGUE_CONDENSE_INFO_KEY
		Stage.ABLE_TO_TRAVEL: return DIALOGUE_TRAVEL_KEY
		_: return ""


func _onTextBubblePressed() -> void:
	dialogueLineIndex += 1
	if dialogueLineIndex < dialogueData.size():
		bubbleLabel.text = dialogueHandler.getFromSpecialKey(dialogueData[dialogueLineIndex], DialogueHandler.SpecialKeys.TEXT)


func _onGrowButtonPressed(toggled : bool) -> void:
	_resetAndDisplayDialogue()
	_onTextBubblePressed()


# When the wheel is making progress in increasing size.
func _onWheelGrowing() -> void:
	_resetAndDisplayDialogue()
