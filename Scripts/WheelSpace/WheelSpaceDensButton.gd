extends Control
class_name WheelSpaceDensityButton

#@ Signals
signal densUp


#@ Export Variables


#@ Public Variables
var ifsucc = false


#@ Onready Variables
@onready var growDisplay : Label = $DensDisplay
@onready var button : Button = $DensToggle
@onready var image : Sprite2D = $DensRectDisp


#@ Virtual Methods
func _ready() -> void:
	button.text = str("Condense")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.spinData.density)
	button.pressed.connect(self._onButtonPressed)
	image.scale.x = GVars.spinData.curSucDens/GVars.spinData.densTresh*2
	image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))


#@ Private Method
#Yu: Removed loop, now triggers on button press instead of every 2 seconds.
func _onButtonPressed() -> void:
	if(GVars.spinData.size > GVars.spinData.sucPerTDens):
		GVars.spinData.size -= GVars.spinData.sucPerTDens
		GVars.spinData.curSucDens += GVars.spinData.sucPerTDens
	if(GVars.spinData.curSucDens >= GVars.spinData.densTresh):
		GVars.spinData.density += 1
		densUp.emit()
		growDisplay.text = str(GVars.spinData.density)
		GVars.spinData.curSucDens = 0
		GVars.spinData.densTresh += 1
		GVars.spinData.wheelPhase = int(GVars.spinData.density)
	image.scale.x = GVars.spinData.curSucDens/GVars.spinData.densTresh*2
