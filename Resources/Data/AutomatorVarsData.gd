extends Resource
class_name AutomatorVarsData

@export var globalAutomatorCostMomentum : float
@export var globalAutomatorCostRust : float
@export var globalAutomatorScalingMomentum : float
@export var globalAutomatorScalingRust : float
@export var rustAutoBuyEnabled : bool
@export var automatorList : Array[AutomatorData]

func _init():
	resetData()
	
func resetData() -> void:
	globalAutomatorCostMomentum = 10000
	globalAutomatorCostRust = 1000
	#exponential scaling
	globalAutomatorScalingMomentum = 1.1
	#multiplicative scaling
	globalAutomatorScalingRust = 2.5
	rustAutoBuyEnabled = true
	automatorList.clear()
	
