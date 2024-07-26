extends Container


#@ Export Variables


#@ Public Variables
var presses = 0.0


#@ Onready Variables
@onready var resetButton : Button = $ResetCounter
@onready var image : Sprite2D = $ResetDisplay


#@ Virtual Methods
func _ready():
	if GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.FIRST):
		show()
	else:
		hide()
	
	resetButton.size = Vector2(200,25)
	resetButton.expand_icon = true
	resetButton.pressed.connect(self._buttonPressed)
	
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))


#@ Private Methods
#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _buttonPressed():
	presses += 1.0
	if presses > 4:
		GVars.challenges = []
		GVars.currentChallenges = []
		GVars.inContract = false
		GVars.spinData.spin = 0
		GVars.spinData.rotations = 0
		GVars.spinData.spinPerClick = 1
		presses = 0
		hide()
	if presses > 0:
		resetButton.text = "5 presses to confirm"
	image.scale.x = 2*presses/5
