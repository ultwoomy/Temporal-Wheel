extends Resource
class_name MushroomData


#@ Signals
# Momentum-gain related signals.
signal momentumBuffValueChanged


#@ Export Variables
@export var level : float
@export var xp : float
@export var xpThresh : float
@export var xpThreshMult : float
@export var currentFarmPlots : Array[MushroomCrop]
@export var timeLeft : Array[float]
@export var pendingRots : float
@export var momentumBuff : float :
	set(value):
		if momentumBuff != value:
			momentumBuff = value
			momentumBuffValueChanged.emit()
@export var ascBuff : float
@export var fearMushBuff : float

func _init():
	resetData()
	
func copy(x, resetFear):
	level = x.level
	xp = x.xp
	xpThresh = x.xpThresh
	xpThreshMult = x.xpThreshMult
	currentFarmPlots = x.currentFarmPlots
	timeLeft = x.timeLeft
	pendingRots = x.pendingRots
	momentumBuff = x.momentumBuff
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
	currentFarmPlots = [null, null, null, null]
	timeLeft = [0,0,0,0]
	pendingRots = 0
	momentumBuff = 1
	ascBuff = 1
	fearMushBuff = 1
