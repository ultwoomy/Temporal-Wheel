extends Container
signal exitUpperContract

#@ Export Variables


#@ Public Variables
var presses : int = 0


#@ Onready Variables
@onready var resetButton : Button = $ResetCounter
@onready var image : Sprite2D = $ResetDisplay


#@ Virtual Methods
func _ready():
	if GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.SECOND):
		show()
	else:
		hide()
	resetButton.text = "Exit Upper Contract"
	resetButton.size = Vector2(200,25)
	resetButton.expand_icon = true
	resetButton.pressed.connect(self._button_pressed)
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))


#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _button_pressed():
	presses += 1
	if presses > 4:
		GVars.challenges = []
		GVars.ifhell = true
		GVars.inContract = false
		GVars.hellChallengeInit = true
		GVars.spinData.spinPerClick = 1
		presses = 0
		emit_signal("exitUpperContract")
		hide()
	if presses > 0:
		resetButton.text = "5 presses to confirm"
	image.scale.x = float(2 * presses) / 5.0
