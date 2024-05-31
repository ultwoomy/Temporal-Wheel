extends Resource
class_name SpinData


#@ Signals
signal wheelPhaseChanged


#@ Export Variables
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
@export var wheelPhase : int :
	set(value):
		wheelPhase = value
		wheelPhaseChanged.emit()
@export var rotations : float
@export var spinSpeed : float


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
	wheelPhase = 1
	rotations = 0
	spinSpeed = 0
