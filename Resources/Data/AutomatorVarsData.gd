extends Resource
class_name AutomatorVarsData

@export var globalAutomatorCostSpin : float
@export var globalAutomatorCostRust : float
@export var globalAutomatorScalingSpin : float
@export var globalAutomatorScalingRust : float

func _init():
	resetData()
	
func resetData() -> void:
	globalAutomatorCostSpin = 10000
	globalAutomatorCostRust = 1000
	#exponential scaling
	globalAutomatorScalingSpin = 1.1
	#multiplicative scaling
	globalAutomatorScalingRust = 2.5
