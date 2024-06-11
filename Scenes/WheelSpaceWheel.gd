extends Node
class_name WheelSpaceWheel


#@ Constants
const RUST_PART = preload("res://Scenes/RustEmitter.tscn")


#@ Global Variables
@onready var centerpiece : AnimatedSprite2D = $Centerpiece
@onready var ascensionButton : Button = $PreAscTransfer
@onready var rustEmitter : RustEmitter = $RustEmitter


#@ Virtual Methods
func _ready() -> void:
	# Connect signals.
	WheelSpinner.rustProgressed.connect(_onRustProgressed)


func _process(delta: float) -> void:
	self.scale = Vector2(0.5 + log(GVars.spinData.size)/5,0.5 + log(GVars.spinData.size)/5)


#@ Public Methods
func updateWheelSprite() -> void:
	# Local Variables
	var frameNumber: int = GVars.spinData.wheelPhase - 1
	
	# Change sprite.
	if frameNumber > 11:
		centerpiece.frame = 11
	elif frameNumber < 0:
		centerpiece.frame = 0
	else:
		centerpiece.frame = frameNumber


# Creates rust instance which should occur when rust is gained.
func createRustInstance() -> void:
	var rus = RUST_PART.instantiate()
	rus.get_child(0).init(1)
	self.add_child(rus)	


#@ Private Methods
func _onRustProgressed(rustPerThresh : float) -> void:
	rustEmitter.changeParticleOnRust(rustPerThresh)
	rustEmitter.emit()
