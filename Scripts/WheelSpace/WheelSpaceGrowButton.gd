extends Node
class_name WheelSpaceGrowButton


#@ Export Variables
@export var growDisplay: Label
@export var button : Button
@export var image : Sprite2D
@export var spinbody: CharacterBody2D


#@ Public Variables
var ifsucc = false


#@ Virtual Methods
func _ready():
	#Yu: Every time one rotation finishes, succ will trigger once. Changed from once per second.
	#    Threshold and threshold multiplier for size reduced accordingly
	
	# Connecting Signals.
	button.pressed.connect(self._buttonPressed)
	WheelSpinner.wheelRotationCompleted.connect(self.suc_loop)
	
	
	if(GVars.spinData.sizeToggle):
		ifsucc = true
	
	button.text = str("Toggle Grow")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.spinData.size)
	
	image.scale.x = GVars.spinData.curSucSize/GVars.spinData.sucTresh*2
	if ifsucc:
		image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
	else :
		image.set_texture(load("res://Sprites/WheelSpace/redrect.png"))


#@ Public Methods
func suc_loop():
	# Local Variables.
	var suc = 0.0;
	var Ebuff = 0;
	var rustUpBuff = GVars.rustData.increaseHunger
	
	if(GVars.curEmotionBuff == 4):
		rustUpBuff = rustUpBuff * GVars.rustData.fourth
	if(GVars.curEmotionBuff == 2):
		Ebuff = (GVars.rustData.fourth - 1) * GVars.spinData.sucTresh
	if(GVars.sigilData.curSigilBuff == 2):
		suc = GVars.spinData.sucPerTick * rustUpBuff * GVars.spinData.sizeRecord + Ebuff
	else:
		suc = GVars.spinData.sucPerTick * rustUpBuff + Ebuff
	if(ifsucc):
		if(GVars.spinData.spin >= suc):
			GVars.spinData.spin -= suc
			GVars.spinData.curSucSize += suc
			if(GVars.spinData.curSucSize >= GVars.spinData.sucTresh):
				GVars.spinData.size += 1
				if(GVars.spinData.size > GVars.spinData.sizeRecord):
					GVars.spinData.sizeRecord = GVars.spinData.size
				growDisplay.text = str(GVars.spinData.size)
				GVars.spinData.curSucSize = 0
				GVars.spinData.sucTresh *= 3
	image.scale.x = GVars.spinData.curSucSize/GVars.spinData.sucTresh*2


#@ Private Methods
func _buttonPressed():
	if ifsucc:
		ifsucc = false
		GVars.spinData.sizeToggle = false
		image.set_texture(load("res://Sprites/WheelSpace/redrect.png"))
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/nono.wav"))
	else :
		ifsucc = true
		GVars.spinData.sizeToggle = true
		image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
		var sf = load("res://Scenes/SoundEffect.tscn").instantiate()
		self.add_child(sf)	
		sf.get_child(0).init(load("res://Sound/SFX/yes.wav"))
	GVars.save_prog()
