extends Resource
class_name DollarData

@export var achievementsCompleted : float

@export var insuranceCost : float
@export var insuranceScaling : float
@export var insuranceAmtSpin : float
@export var insuranceAmtRot : float
@export var insuranceAmtSpinUp : float
@export var insuranceAmtRotUp : float

func _init():
	resetData()

func resetData() -> void:
	achievementsCompleted = 0
	insuranceCost = 6
	#additive scaling
	insuranceScaling = 3
	insuranceAmtSpin = 100
	insuranceAmtRot = 10
	#multiplicative scaling
	insuranceAmtSpinUp = 3
	#additive scaling
	insuranceAmtRotUp = 5
	
