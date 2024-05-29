extends Resource
class_name SigilData


@export var costSpin : float
@export var costRot : float
@export var costSpinScale : float
@export var costRotScale : float
@export var numberOfSigils : Array[bool]
@export var curSigilBuff : int


# L.B: Use for better legibility on what sigil is being used in code.
enum Sigils {
	PACKSMITH,
	CANDLE,
	ASCENSION,
	EMPTINESS,
	RITUAL,
	HELL,
}


var activeSigils : Dictionary = {
	packsmith = false,
	candle = false,
	ascension = false,
	emptiness = false,
	ritual = false,
	hell = false,
}


func resetData() -> void:
	costSpin = 300
	costRot = 10
	costSpinScale = 1.24
	costRotScale = 3
	numberOfSigils = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
	curSigilBuff = 0
	
	for key in activeSigils:
		key = false

func _init():
	resetData()