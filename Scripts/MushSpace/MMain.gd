extends Node
#@export var left : Button
#@export var right : Button
#@export var plant : Button
#@export var remove : Button
#@export var plot1 : AnimatedSprite2D
#@export var plot2 : AnimatedSprite2D
#@export var plot3 : AnimatedSprite2D
#@export var plot4 : AnimatedSprite2D
#@export var disp1 : Label
#@export var disp2 : Label
#@export var disp3 : Label
#@export var disp4 : Label
#@export var harvest : Button
@export var currentMush : AnimatedSprite2D
#@export var desc : Label
#@export var xpbar : Sprite2D
#@export var leveldisp : Label
#@export var statsdisp : Label
#@export var curFrame : int


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.mushroomData.pendingRots < 0):
		GVars.mushroomData.pendingRots = 0
	if(GVars.sigilData.curSigilBuff == 2):
		GVars.mushroomData.pendingRots *= 1.5
	for n in GVars.mushroomData.current.size():
		GVars.mushroomData.timeLeft[n] -= GVars.mushroomData.pendingRots
		if(GVars.mushroomData.timeLeft[n] <= 0):
			GVars.mushroomData.timeLeft[n] = 0
	GVars.mushroomData.pendingRots = 0

