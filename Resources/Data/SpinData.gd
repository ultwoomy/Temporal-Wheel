extends Resource
class_name SpinData


#@ Signals
signal momentumValueChanged(addend : float)

# Momentum-gain related signals.
signal momentumPerClickValueChanged
signal sizeValueChanged
signal rotationValueChanged
signal densityValueChanged

signal wheelPhaseChanged


#@ Export Variables
@export var momentum : float :
	set(value):
		var addend : float = value - momentum
		momentum = value
		momentumValueChanged.emit(addend)
@export var momentumPerClick : float :
	set(value):
		if momentumPerClick != value:
			momentumPerClick = value
			momentumPerClickValueChanged.emit()  # Calculating momentum gain.
@export var size : float :
	set(value):
		if size != value:
			size = value
			sizeValueChanged.emit()  # Calculating momentum gain.
@export var sizeToggle : bool
@export var sucPerTick : float
@export var sucTresh : float
@export var curSucSize : float
@export var sizeRecord : float
@export var density : float :
	set(value):
		if density != value:
			density = value
			densityValueChanged.emit()  # Calculating momentum gain.
@export var sucPerTDens : float
@export var densTresh : float
@export var curSucDens : float
@export var wheelPhase : int :
	set(value):
		wheelPhase = value
		wheelPhaseChanged.emit()
@export var rotations : float :
	set(value):
		if rotations != value:
			rotations = value
			rotationValueChanged.emit()  # Calculating momentum gain.
@export var spinSpeed : float

func _init():
	resetData()
	

func resetData() -> void:
	momentum = 0
	momentumPerClick = 1
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
