extends Resource
class_name HuntData

@export var rotationsTravelled : float
@export var endGoal : float
@export var acquiredSouls : Array[HuntSoul]
@export var soulsDisplayOrder : Array[HuntSoul]
@export var soulTarget : HuntSoul
@export var huntLevel : int
@export var huntXpThresh : float
@export var huntXp : float
# Additive scaling
@export var huntXpScaling : float


func _init():
	resetData()

func resetData() -> void:
	rotationsTravelled = 0
	endGoal = 0
	acquiredSouls = []
	soulsDisplayOrder = []
	huntXp = 0
	huntXpThresh = 50
	huntXpScaling = 30
