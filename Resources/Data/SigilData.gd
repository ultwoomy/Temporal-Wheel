extends Resource
class_name SigilData


#@ Export Variables
@export var costSpin : float
@export var costRot : float
@export var costSpinScale : float
@export var costRotScale : float
@export var acquiredSigils : Array[Sigil]
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
	acquiredSigils = []
	curSigilBuff = -1
	
	for key in activeSigils:
		key = false

func _init():
	resetData()
