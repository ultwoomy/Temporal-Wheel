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
	EventManager.challenge_lost_L2.connect(self.refresh)
	resetButton.pressed.connect(self._button_pressed)
	refresh()



#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _button_pressed():
	presses += 1
	if presses > 4:
		GVars.resetChallengeVars()
		EventManager.emit_signal("challenge_lost_L2")
		EventManager.emit_signal("disconnect_thorns")
		GVars.challengesFailed += 1
		presses = 0
		hide()
	if presses > 0:
		resetButton.text = "5 presses to confirm"
	image.scale.x = float(2 * presses) / 5.0

func refresh():
	if GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.SECOND):
		show()
	else:
		hide()
	resetButton.text = "Exit Upper Contract"
	resetButton.size = Vector2(200,25)
	resetButton.expand_icon = true
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
