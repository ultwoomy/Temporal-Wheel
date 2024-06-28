extends Node
# Autoload script.


#@ Virtual Methods
func _ready() -> void:
	# Listeners
	if not WheelSpinner.wheelRotationCompleted.is_connected(_onWheelRotationCompleted):
		WheelSpinner.wheelRotationCompleted.connect(_onWheelRotationCompleted)


#@ Public Methods


#@ Private Methods
func _onWheelRotationCompleted() -> void:
	# Local Variables
	var basePendingRotationValue : float = WheelSpinner.wheelRotation / WheelSpinner.FULL_ROTATION_RADIANS  # Usually just a value of 1.
	
	const candleSigil : Sigil = preload("res://Resources/Sigil/CandleSigil.tres")
	if candleSigil in GVars.sigilData.acquiredSigils:
		print(str(basePendingRotationValue * GlobalBuffs.mushroomPendingRotationModifier))
		GVars.mushroomData.pendingRots += basePendingRotationValue * GlobalBuffs.mushroomPendingRotationModifier
		if(GVars.ritualData.candlesLit[1]):
			GVars.mushroomData.xp += GVars.mushroomData.xpThresh/(50 * GVars.mushroomData.level)
