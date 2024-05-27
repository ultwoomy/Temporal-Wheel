extends Resource
class_name SigilData

@export var costSpin : float
@export var costRot : float
@export var costSpinScale : float
@export var costRotScale : float
@export var numberOfSigils : Array[bool]
@export var curSigilBuff : int

func _init():
	resetData()
	
func resetData() -> void:
	costSpin = 300
	costRot = 10
	costSpinScale = 1.24
	costRotScale = 3
	numberOfSigils = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
	curSigilBuff = 0
