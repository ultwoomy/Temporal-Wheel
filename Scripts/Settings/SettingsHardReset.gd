extends Container


#@ Export Variables
@export var button : Button
@export var image : Sprite2D


#@ Public Variables
var presses = 0.0


#@ Virtual Methods
func _ready():
	button.size = Vector2(200,100)
	button.pressed.connect(self._buttonPressed)
	image.scale.x = 0
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))


#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _buttonPressed():
	presses += 1.0
	if presses > 9:
		GVars.create_data()
		GVars.resetR0Stats()
		GVars.resetR1Stats()
		GVars.resetR2Stats()
		GVars.resetPermStats()
		button.text = "Game Reset!"
		presses = 0
	if presses > 0:
		button.text = "Hard Reset\nPress 10 times to\nconfirm"
	image.scale.x = presses/5
