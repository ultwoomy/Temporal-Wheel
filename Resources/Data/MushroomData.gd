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

func _init():
	resetData()
	
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
