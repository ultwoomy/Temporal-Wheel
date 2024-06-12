extends Node
@export var currentMush : AnimatedSprite2D
@export var background : AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.mushroomData.pendingRots < 0):
		GVars.mushroomData.pendingRots = 0
	if(GVars.sigilData.curSigilBuff == 1):
		GVars.mushroomData.pendingRots *= 1.5
	for n in GVars.mushroomData.current.size():
		GVars.mushroomData.timeLeft[n] -= GVars.mushroomData.pendingRots
		if(GVars.mushroomData.timeLeft[n] <= 0):
			GVars.mushroomData.timeLeft[n] = 0
	GVars.mushroomData.pendingRots = 0
	if(GVars.mushroomData.level >= 10):
		background.frame = 2

