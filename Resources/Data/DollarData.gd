extends Resource
class_name DollarData

@export var dollarSpinCost : float
@export var dollarSpinScaling : float
@export var dollarSpinAmt : float
@export var dollarRotCost : float
@export var dollarRotScaling : float
@export var dollarRotAmt : float
@export var dollarRustCost : float
@export var dollarRustScaling : float
@export var dollarRustAmt : float

@export var ascBuffPerDollarCost : float
@export var ascBuffPerDollarScaling : float
@export var ascBuffPerDollarAmt : float
#below variable is how much ascBuffPerDollarAmt goes up per time upgraded
@export var ascBuffPerDollarUp : float

@export var insuranceCost : float
@export var insuranceScaling : float
@export var insuranceAmtSpin : float
@export var insuranceAmtRot : float
@export var insuranceAmtSpinUp : float
@export var insuranceAmtRotUp : float


func resetData() -> void:
	dollarSpinCost = 10000
	#exponential scaling
	dollarSpinScaling = 1.1
	dollarSpinAmt = 0
	dollarRotCost = 60
	#multiplicative scaling
	dollarRotScaling = 2.5
	dollarRotAmt = 0
	dollarRustCost = 2
	#multiplicative scaling
	dollarRustScaling = 5
	dollarRustAmt = 0
	
	ascBuffPerDollarCost = 2
	#additive scaling
	ascBuffPerDollarScaling = 2
	ascBuffPerDollarAmt = 0.3
	ascBuffPerDollarUp = 0.1
	
	insuranceCost = 6
	#additive scaling
	insuranceScaling = 3
	insuranceAmtSpin = 100
	insuranceAmtRot = 10
	#multiplicative scaling
	insuranceAmtSpinUp = 3
	#additive scaling
	insuranceAmtRotUp = 5
