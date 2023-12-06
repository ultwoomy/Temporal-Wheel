extends Node
@export var growDisplay: Label
@export var button : Button
@export var image : Sprite2D
@export var spinbody: CharacterBody2D
var ifsucc = false
func _ready():
	#Yu: Every time one rotation finishes, succ will trigger once. Changed from once per second.
	#    Threshold and threshold multiplier for size reduced accordingly
	if(GVars.sizeToggle):
		ifsucc = true
	spinbody.oneClick.connect(suc_loop)
	button.text = str("Toggle Grow")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.size)
	button.pressed.connect(self._button_pressed)
	image.scale.x = GVars.curSucSize/GVars.sucTresh*2
	if(ifsucc):
		image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
	else :
		image.set_texture(load("res://Sprites/WheelSpace/redrect.png"))

func _button_pressed():
	if(ifsucc):
		ifsucc = false
		GVars.sizeToggle = false
		image.set_texture(load("res://Sprites/WheelSpace/redrect.png"))
	else :
		ifsucc = true
		GVars.sizeToggle = true
		image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
	GVars.save_prog()
	
func suc_loop():
	var suc = 0.0;
	var Ebuff = 0;
	var rustUpBuff = GVars.Rincreasehunger
	if(GVars.curEmotionBuff == 4):
		rustUpBuff = rustUpBuff * GVars.Rfourth
	if(GVars.curEmotionBuff == 2):
		Ebuff = GVars.Rfourth * GVars.sucTresh
	if(GVars.curSigilBuff == 3):
		suc = GVars.sucPerTick * rustUpBuff * GVars.sizeRecord + Ebuff
	else:
		suc = GVars.sucPerTick * rustUpBuff + Ebuff
	print(str(suc))
	if(ifsucc):
		if(GVars.spin >= suc):
			GVars.spin -= suc
			GVars.curSucSize += suc
			if(GVars.curSucSize >= GVars.sucTresh):
				GVars.size += 1
				if(GVars.size > GVars.sizeRecord):
					GVars.sizeRecord = GVars.size
				growDisplay.text = str(GVars.size)
				GVars.curSucSize = 0
				GVars.sucTresh *= 3
	image.scale.x = GVars.curSucSize/GVars.sucTresh*2
