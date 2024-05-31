extends Node
class_name WheelSpaceWheel


#@ Global Variables
@onready var centerpiece : AnimatedSprite2D = $Centerpiece
@onready var ascensionButton : Button = $PreAscTransfer


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
