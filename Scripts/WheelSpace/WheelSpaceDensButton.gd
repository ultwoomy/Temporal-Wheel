extends Node
@export var growDisplay: Label
@export var button : Button
@export var image : Sprite2D
var ifsucc = false
func _ready():
	button.text = str("Condense")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.density)
	button.pressed.connect(self._button_pressed)
	image.scale.x = GVars.curSucDens/GVars.densTresh*2
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))

#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _button_pressed():
	if(GVars.size > GVars.sucPerTDens):
		GVars.size -= GVars.sucPerTDens
		GVars.curSucDens += GVars.sucPerTDens
	if(GVars.curSucDens >= GVars.densTresh):
		GVars.density += 1
		growDisplay.text = str(GVars.density)
		GVars.curSucDens = 0
		GVars.sucPerTDens *= 2
		GVars.densTresh *= 2
		GVars.wheelphase = int(GVars.density)
		image.scale.x = GVars.curSucDens/GVars.densTresh*2
