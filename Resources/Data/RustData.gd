extends Resource
class_name RustData

@export var rust : float
@export var increaseSpin : float
@export var increaseSpinCost : float
@export var increaseSpinScaling : float
@export var increaseHunger : float
@export var increaseHungerCost : float
@export var increaseHungerScaling : float
@export var increaseRust : float
@export var increaseRustCost : float
@export var increaseRustScaling : float
@export var fourth : float
@export var fourthCost : float
@export var fourthScaling : float
@export var thresh : float
@export var perThresh : float
@export var threshProgress : float
@export var threshMult : float


func resetData() -> void:
	rust = 0
	increaseSpin = 1
	increaseSpinCost = 1
	increaseSpinScaling = 1.5
	increaseHunger = 1
	increaseHungerCost = 1
	increaseHungerScaling = 2
	increaseRust = 1
	increaseRustCost = 2
	increaseRustScaling = 3
	fourth = 1
	fourthCost = 3
	fourthScaling = 2
	thresh = 1
	perThresh = 1
	threshProgress = 1
	threshMult = 1.25
