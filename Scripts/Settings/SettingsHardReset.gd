extends Container
@export var button : Button
@export var image : Sprite2D
var presses = 0.0
func _ready():
	button.text = "Hard Reset"
	button.size = Vector2(200,100)
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))

#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _button_pressed():
	presses += 1.0
	if(presses > 9):
		GVars.resetR0Stats()
		GVars.resetR1Stats()
		GVars.resetPermStats()
		button.text = "Game Reset!"
		presses = 0
	if(presses > 0):
		button.text = "Hard Reset\nPress 10 times to\nconfirm"
	image.scale.x = presses/5
