extends Node
class_name WheelSpaceWheel


#@ Constants


#@ Global Variables
@onready var centerpiece : AnimatedSprite2D = $Centerpiece
@onready var ascensionButton : Button = $PreAscTransfer
@onready var rustEmitter : RustEmitter = $RustEmitter


#@ Virtual Methods
func _ready() -> void:
	# Connect signals.
	WheelSpinner.rustProgressed.connect(_onRustProgressed)
	
	# Scale the wheel based on the given size.
	self.scale = Vector2(0.5 + log(GVars.spinData.size)/5, 0.5 + log(GVars.spinData.size)/5)


func _process(delta: float) -> void:
	# Scale the wheel based on the given size.
	self.scale = Vector2(0.5 + log(GVars.spinData.size)/5, 0.5 + log(GVars.spinData.size)/5)
	
	# Rotates the wheel.
	self.rotation = WheelSpinner.wheelRotation


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


#@ Private Methods
func _onRustProgressed(rustPerThresh : float) -> void:
	rustEmitter.changeParticleOnRust(rustPerThresh)
	rustEmitter.emit()