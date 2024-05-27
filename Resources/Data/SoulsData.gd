extends Resource
class_name SoulsData

@export var souls : float
@export var voidRust : float
@export var soulThresh : float

@export var spinBaseBuff : float
@export var spinBaseBuffCost : float
@export var spinBaseBuffScaling : float
@export var spinBaseBuffEnabled : bool

@export var voidRustChance : float
@export var voidRustChanceCost : float
@export var voidRustChanceScaling : float
@export var voidRustChanceEnabled : bool

@export var doubleRotChance : float
@export var doubleRotChanceCost : float
@export var doubleRotChanceScaling : float
@export var doubleRotChanceEnabled : bool

@export var doubleShroomChance : float
@export var doubleShroomChanceCost : float
@export var doubleShroomChanceScaling : float
@export var doubleShroomChanceEnabled : bool

func _init():
	resetData()
	
func resetData() -> void:
	souls = 0
	voidRust = 0
	soulThresh = 4
	
	spinBaseBuff = 0
	spinBaseBuffCost = 5
	spinBaseBuffScaling = 5
	spinBaseBuffEnabled = false
	
	voidRustChance = 0
	voidRustChanceCost = 5
	voidRustChanceScaling = 5
	voidRustChanceEnabled = false
	
	doubleRotChance = 0
	doubleRotChanceCost = 5
	doubleRotChanceScaling = 5
	doubleRotChanceEnabled = false
	
	doubleShroomChance = 0
	doubleShroomChanceCost = 5
	doubleShroomChanceScaling = 5
	doubleShroomChanceEnabled = false
