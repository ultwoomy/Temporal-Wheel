extends Resource
class_name KbityData

@export var kbityProgSpin : float
@export var kbityProgRot : float
@export var kbityThreshSpin : float
@export var kbityThreshRot : float
@export var kbityAddSpin : float
@export var kbityAddRot : float
@export var kbitySpinCheck : bool
@export var kbityRotCheck : bool
@export var kbityLevel : int
#represents multiplicative scaling
@export var kbityRotBuff : float


func resetData() -> void:
	kbityProgSpin = 0
	kbityProgRot = 0
	kbityThreshSpin = 1000000000000
	kbityThreshRot = 10000
	kbityAddSpin = 0
	kbityAddRot = 0
	kbitySpinCheck = false
	kbityRotCheck = false
	kbityLevel = 0
	kbityRotBuff = 1.00
