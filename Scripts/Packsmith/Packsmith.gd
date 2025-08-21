extends Node2D
class_name Packsmith


#@ Enumerators


#@ Constants
const EYEBROW_ANIMATION_NAMES : Array[String] = [
	"angry",
	"default",
	"mean",
	"surprised",
]


#@ Public Variables
var state : PacksmithState
var dialogueFaceExpressions : Array[String] = []


#@ Onready Variables
@onready var headSprites : AnimatedSprite2D = $HeadSprites
@onready var eyebrowSprites : AnimatedSprite2D = $EyebrowSprites
@onready var eyeSprite : Sprite2D = $EyeSprite
@onready var neckSprite : Sprite2D = $NeckSprite


#@ Virtual Methods
func _ready() -> void:
	var newState : PacksmithState
	if GVars.ifFirstPack:
		newState = PacksmithPeakState.new(self)
	else:
		newState = PacksmithDefaultState.new(self)
	changeState(newState)


#@ Public Methods
func changeState(newState : PacksmithState) -> void:
	if state:
		state._exit()
	state = newState
	state._enter()


func expressEmotion(headAnimation : String = "default", eyebrowAnimation : String = "default") -> void:
	headSprites.animation = headAnimation
	_displayEyebrow(eyebrowAnimation)


func getFaceExpressionsFromDialogueData(dialogueData : Array[Dictionary]) -> void:
	# Empty array out if needed.
	if dialogueFaceExpressions:
		dialogueFaceExpressions.clear()
	
	# Get the order of facial expressions from every dialogue in the dialogue data.
	for dialogue in dialogueData:
		var specialKeyStringForAnimation : String = DialogueHandler.SpecialKeys.find_key(DialogueHandler.SpecialKeys.ANIMATION_NAME)
		dialogueFaceExpressions.append(dialogue[specialKeyStringForAnimation])


func playNextFaceExpression() -> void:
	if not dialogueFaceExpressions.is_empty():
		var expressionPresetName : String = dialogueFaceExpressions.pop_front()
		
		_expressEmotionFromPreset(expressionPresetName)


#@ Private Methods
# NOTE: This is a work around from having to change the JSON!
#  The JSON, as of currently, only has one field that determines the animation name!
#  Since Packsmith has more than one sprite, the animation names don't line up!
func _expressEmotionFromPreset(presetName : String) -> void:
	match presetName:
		"TALKING":
			expressEmotion("talking", "mean")
		"EYEBROW":
			expressEmotion("default", "surprised")
		"CONCERN":
			expressEmotion("default", "flat")
		_:
			expressEmotion()


func _displayEyebrow(eyebrowAnimation : String) -> void:
	var showRequirements : bool = not (eyebrowAnimation in EYEBROW_ANIMATION_NAMES) or (eyebrowAnimation == "default")
	eyebrowSprites.visible = not showRequirements
	eyebrowSprites.animation = eyebrowAnimation
	
	# Reposition eyebrow.
	match eyebrowSprites.animation:
		"angry":
			#
			# TODO
			#
			eyebrowSprites.position = Vector2()
		"surprised":
			eyebrowSprites.position = Vector2(165, -190)
		"flat":
			#
			# TODO
			#
			eyebrowSprites.position = Vector2()
		_:  # Default for "mean"
			eyebrowSprites.position = Vector2(122, -177)
