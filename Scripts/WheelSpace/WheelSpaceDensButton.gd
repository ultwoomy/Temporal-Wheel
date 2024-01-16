extends Node
@export var growDisplay: Label
@export var button : Button
@export var image : Sprite2D
var ifsucc = false
signal densUp
func _ready():
	button.text = str("Condense")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.spinData.density)
	button.pressed.connect(self._button_pressed)
	image.scale.x = GVars.spinData.curSucDens/GVars.spinData.densTresh*2
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))

#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _button_pressed():
	if(GVars.spinData.size > GVars.spinData.sucPerTDens):
		GVars.spinData.size -= GVars.spinData.sucPerTDens
		GVars.spinData.curSucDens += GVars.spinData.sucPerTDens
	if(GVars.spinData.curSucDens >= GVars.spinData.densTresh):
		GVars.spinData.density += 1
		emit_signal("densUp")
		growDisplay.text = str(GVars.spinData.density)
		GVars.spinData.curSucDens = 0
		GVars.spinData.densTresh += 1
		GVars.spinData.wheelphase = int(GVars.spinData.density)
	image.scale.x = GVars.spinData.curSucDens/GVars.spinData.densTresh*2
