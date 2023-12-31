extends Resource
class_name SpinData

@export var spin : float
@export var spinPerClick : float
@export var size : float
@export var sizeToggle : bool
@export var sucPerTick : float
@export var sucTresh : float
@export var curSucSize : float
@export var sizeRecord : float
@export var density : float
@export var sucPerTDens : float
@export var densTresh : float
@export var curSucDens : float
@export var wheelphase : int
@export var rotations : float

func resetData() -> void:
	spin = 0
	spinPerClick = 1
	size = 1
	sizeToggle = false
	sucPerTick = 5
	sucTresh = 15
	curSucSize = 0
	sizeRecord = 1
	density = 1
	sucPerTDens = 1
	densTresh = 2
	curSucDens = 0
	wheelphase = 1
	rotations = 0
