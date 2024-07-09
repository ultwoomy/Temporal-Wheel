extends AnimatedSprite2D


#@ Signals


#@ Constants
const endSequenceFinalFrame : int = 750


#@ Exported Variables


#@ Public Variables
var rotationSpeed : float = 0.001
var endSequence : bool = false
var endSequenceFrames : int = 0.00


#@ Onready Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateWheelSprite(GVars.spinData.density - 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	rotateWheel()


#@ Public Methods
func rotateWheel() -> void:
	self.rotation += rotationSpeed
	
	if endSequence:
		rotationSpeed += 0.0005
		
		# End sequence completed when set amount of frame has been reached.
		if endSequenceFrames < endSequenceFinalFrame:
			endSequenceFrames += 1
		else:
			SceneHandler.changeSceneToFilePath(SceneHandler.ASCENSIONSPACE)
		
		# Continually increase size of wheel.
		var newScaleSize : float = pow(1 + rotationSpeed * endSequenceFrames / 30.0, 2)
		self.scale = Vector2(newScaleSize, newScaleSize)
		
		# Continually change color of wheel after a certain amount of frames has been reached.
		if endSequenceFrames > endSequenceFinalFrame - 100:
			var newColorValue : float = 1 - (endSequenceFrames - (endSequenceFinalFrame - 100))/100.0
			self.modulate = Color(newColorValue, newColorValue, newColorValue)


func updateWheelSprite(frameNumber : int) -> void:
	# Error checking.
	if not frameNumber:
		self.frame = 0
	elif frameNumber > 11:
		self.frame = 11
	else:
		self.frame = frameNumber


func setEndSequence(boolean : bool) -> void:
	endSequence = boolean


#@ Private Methods
