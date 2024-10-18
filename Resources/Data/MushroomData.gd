extends Resource
class_name MushroomData

@export var level : float
@export var xp : float
@export var xpThresh : float
@export var xpThreshMult : float
@export var current : Array[int]
@export var timeLeft : Array[float]
@export var pendingRots : float
@export var spinBuff : float
@export var ascBuff : float
@export var fearMushBuff : float

func _init():
	resetData()
	
func copy(x, resetFear):
	level = x.level
	xp = x.xp
	xpThresh = x.xpThresh
	xpThreshMult = x.xpThreshMult
	current = x.current
	timeLeft = x.timeLeft
	pendingRots = x.pendingRots
	spinBuff = x.spinBuff
	ascBuff = x.ascBuff
	if resetFear:
		fearMushBuff = 1
	else:
		fearMushBuff = x.fearMushBuff
	
func resetData() -> void:
	level = 1
	xp = 0
	xpThresh = 100
	xpThreshMult = 1.5
	current = [0,0,0,0]
	timeLeft = [0,0,0,0]
	pendingRots = 0
	spinBuff = 1
	ascBuff = 1
	fearMushBuff = 1
