extends Container
@export var button : Button
@export var image : Sprite2D
var presses = 0.0
func _ready():
	if(GVars.inContract):
		show()
	else:
		hide()
	button.text = "Exit Contract"
	button.size = Vector2(200,25)
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))

#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _button_pressed():
	presses += 1.0
	if(presses > 4):
		GVars.hellChallengeNerf = -1
		GVars.inContract = false
		presses = 0
		hide()
	if(presses > 0):
		button.text = "5 presses to confirm"
	image.scale.x = 2*presses/5
