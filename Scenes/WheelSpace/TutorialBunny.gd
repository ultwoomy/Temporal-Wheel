extends Control
class_name TutorialBunny


#@ Signals
signal changedState(state : TutorialBunnyState)


#@ Constants
const END_POSITION : Vector2 = Vector2(650,390)
const DURATION_OF_TRAVEL : float = 2.0  # Time it takes for the bunny to travel to end position.


#@ Public Variables
var frame : int = 0
var phase : int = 0
var ifFirstGrowPress : bool = true
var state : TutorialBunnyState
var lines : Array[String] = ["", "", "", "Grow absorbs momentum to increase size",
			 "Each level of size takes more momentum",
			 "Momentum gain is multiplied by size",
			 "Talk to me again when you have 3 size",
			 "Density costs 1 more size than its current value",
			 "But you can't have 0 size, so you'll need 3",
			 "Would you look at that, you have 3 size!",
			 "Pressing condense will increase the wheel's density",
			 "Each level of density makes the wheel spin faster", 
			 "It's almost time for us to part",
			 "You've pressed Condense right?",
			 "Press Travel and head to Voidspace",
			 "I'll tell ya the rest there"]


#@ Onready Variables
@onready var bunnySprite : Sprite2D = $BunnySprite
@onready var textBubble : TextureButton = $TextBubble
@onready var text : Label = $Label

@onready var tween : Tween = self.create_tween()


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	bunnySprite.hide()
	textBubble.hide()
	text.hide()
	
	# Listen to signals.
	textBubble.pressed.connect(_onTextBubblePressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.position == END_POSITION:
		bubbleOne()
	if phase == 1 and not GVars.spinData.sizeToggle and not ifFirstGrowPress:
		text.text = "You just toggled it off, click Grow again"
	elif phase == 1 and GVars.spinData.sizeToggle and not ifFirstGrowPress:
		text.text = "Now wait for a full wheel rotation"


#@ Public Methods
func introduceSelf():
	bunnySprite.show()
	tween.tween_property(self, "position", END_POSITION, DURATION_OF_TRAVEL)


func changeState(newState : TutorialBunnyState) -> void:
	if state:
		state._exit()
	state = newState
	state._enter()


## TODO: Keep this function but use it as a way to remember what state to put the TutorialBunny in.
func bubbleOne():
	text.show()
	textBubble.show()
	if GVars.spinData.density > 1:
		phase = 13
		_onTextBubblePressed()
	elif GVars.spinData.size > 2:
		phase = 6
		_onTextBubblePressed()
	elif GVars.spinData.size > 1:
		phase = 5
		_onTextBubblePressed()
	elif GVars.spinData.curSucSize > 0:
		phase = 2
		_onTextBubblePressed()
	else:
		text.text = "Hellos! Press grow to toggle it on"
		phase = 1


func growClicked():
	if phase < 2:
		text.text = "Now we wait for a full wheel rotation"
		ifFirstGrowPress = false


func fullRotation():
	if phase == 1:
		text.text = "(Click bubble to advance dialogue)"
		phase += 1


func _onTextBubblePressed():
	if phase >= 2:
		if nextPhaseCondition():
			phase += 1
		text.text = lines[phase]


func nextPhaseCondition() -> bool:
	if phase == 2:
		return true
	elif phase >= 3 and phase <= 5:
		return true
	elif phase == 6:
		return GVars.spinData.size > 2
	elif phase >= 7 and phase <= 12:
		return true
	elif phase == 13:
		return GVars.spinData.density >= 2
	elif phase == 14:
		return true
	return false
