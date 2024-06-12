extends Container


#@ Export Variables
@export var button : Button
@export var image : Sprite2D


#@ Public Variables
var presses = 0.0


#@ Virtual Methods
func _ready():
	if GVars.hellChallengeNerf >= 0:
		show()
	else:
		hide()
	button.text = "Exit Contract"
	button.size = Vector2(200,25)
	button.expand_icon = true
	button.pressed.connect(self._buttonPressed)
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))


#@ Private Methods
#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _buttonPressed():
	presses += 1.0
	if(presses > 4):
		GVars.hellChallengeNerf = -1
		GVars.inContract = false
		GVars.spinData.spin = 0
		GVars.spinData.rotations = 0
		GVars.spinData.spinPerClick = 1
		presses = 0
		hide()
	if(presses > 0):
		button.text = "5 presses to confirm"
	image.scale.x = 2*presses/5
