extends Node2D
class_name Packsmith


#@ Enumerators


#@ Constants


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
	eyebrowSprites.animation = eyebrowAnimation


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
		var expressionName : String = dialogueFaceExpressions.pop_front().to_lower()
		
		expressEmotion(expressionName, expressionName)


#@ Private Methods
