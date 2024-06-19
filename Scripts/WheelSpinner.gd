extends Node
# Autoload script.
# Runs calculations for wheel-related things.


#@ Signals
signal spinValueChanged
signal wheelRotationCompleted
signal rustProgressed(rustPerThresh : float)


#@ Constants
const FULL_ROTATION_RADIANS : float = 2*PI


#@ Public Variables
# Needed so that the Player doesn't have to be in WheelSpace scene for wheel to rotate.
# wheelRotation keeps track of the value, but doesn't do anything itself.
var wheelRotation : float = 0.0


#@ Private Variables
var _sign : int = 1 :
	set(value):  # Make sure value is either -1 or 1.
		if value < -1:
			_sign = -1
		else:
			_sign = 1


#@ Virtual Methods
func _process(_delta: float) -> void:
	rotateWheel()


#@ Public Methods
func spinWheel(reverse: bool = false) -> void:
	if not reverse:
		GVars.spinData.spin += _calculateSpinGain()
	else:
		GVars.spinData.spin += GVars.sucPerTick * GVars.rustData.increaseHunger * 5
	spinValueChanged.emit()


func rotateWheel() -> void:
	# Reset rotation
	if abs(wheelRotation) > FULL_ROTATION_RADIANS:
		_completeRotation()
	
	# No spins then no rotating the wheel.
	if GVars.spinData.spin <= 0:
		return
	
	# Get the direction that the wheel should be rotating towards. Counter-clockwise is negative.
	if GVars.ritualData.candlesLit[0]:
		_sign = -1
	else:
		_sign = 1
	
	# Rotate wheel in a direction based on the candle lit(?).
	wheelRotation += getWheelRotationAmount() * _sign
	
	# Gain rust progress and possibly rust when wheel is rotating.
	var rustCalculation : float = _calculateRust()
	if GVars.rustData.threshProgress > GVars.rustData.thresh:
		GVars.rustData.threshProgress -= _calculateThreshProgress()
		GVars.rustData.rust += rustCalculation
		GVars.rustData.thresh *= _calculateThresh()
		
		# Signal rust progression.
		rustProgressed.emit(rustCalculation)


# Probably move this in WheelSpaceWheel(?), or a script that is global.
func getWheelRotationAmount() -> float:
	var result : float = log(GVars.spinData.spin)/log(2)
	# Divide by the speed divisor, which is based off the wheel phase.
	result /= _getRotationSpeedDivisor()
	# Reduce amount by the amount of lit candles .
	var numOfLitCandles : int = 0
	for boolean in GVars.ritualData.candlesLit:
		if boolean:
			numOfLitCandles += 1
	result *= 1 - (0.2 * numOfLitCandles)
	# Increase amount from global buffs, such as emotionBuff.
	result *= GlobalBuffs.wheelRotationGainModifier

	# Increase amount by rot buff.
	result *= GVars.ritualData.rotBuff
	return result


#@ Private Methods
func _calculateSpinGain() -> float:
	# Base result Player gets from spinning the wheel with a click.
	var result : float = GVars.spinData.spinPerClick
	# Multiply the result by the size of the wheel.
	result *= GVars.spinData.size
	# Multiply the result by the density of the wheel.
	result *= GVars.spinData.density
	# Multiply the result by the rust purchasable upgrade, increase spin.
	result *= GVars.rustData.increaseSpin
	
	## BUFFS, should probably be in Buffs.gd.
	# Multiply the result by the buffs granted by growing mushrooms.
	result *= GVars.mushroomData.spinBuff
	# Multiply the result by the buff granted by ascension(?).
	result *= GVars.Aspinbuff
	# Multiply the result by the buff granted by emotion(?) from ascension(?).
	if GVars.curEmotionBuff == 4:
		# Note: This is the same as "result *= GVars.rustData.fourth", but was written similar to this in previous code.
		var emotionBuffMultiplier: float = GVars.rustData.fourth
		result *= emotionBuffMultiplier
	return result


# L.B: Utilizes my JSONReader class to load in a .json file intentionally written for this specific function.
func _getRotationSpeedDivisor() -> float:
	var result : float
	var wheelPhaseJSON : Dictionary = JSONReader.new().loadJSONFile("res://JSON/WheelPhases.json")
	var wheelPhaseIndexOffset : int = GVars.spinData.wheelPhase - 1
	
	if wheelPhaseIndexOffset >= wheelPhaseJSON["rotationSpeedDivisor"].size():
		result = wheelPhaseJSON["rotationSpeedDivisor"][wheelPhaseJSON["rotationSpeedDivisor"].size() - 1]
	elif wheelPhaseIndexOffset < 0:
		result = wheelPhaseJSON["rotationSpeedDivisor"][0]
	else:
		result = wheelPhaseJSON["rotationSpeedDivisor"][wheelPhaseIndexOffset]
	return result


# When the wheel completely turns a full circle, it runs a couple of things.
func _completeRotation() -> void:
	# Gain spin.
	spinWheel()  # Should I really have this func be called "spinWheel()"?
	
	# Candle #3(?) is lit.
	if GVars.ritualData.candlesLit[2]:
		var numerator : float = log(GVars.spinData.rotations) * GVars.Aspinbuff
		var denominator : float
		if _sign == -1:
			denominator = GVars.ritualData.ascBuff * GVars.spinData.rotations * 10
		else:
			denominator = GVars.ritualData.ascBuff * GVars.spinData.rotations * 5
		GVars.ritualData.ascBuff += numerator / denominator * _sign
	
	# Candle #4(?) is lit.
	if GVars.ritualData.candlesLit[3]:
		GVars.rustData.rust += 0.1 * _sign
	
	# Candle #5(?) is lit.
	if GVars.ritualData.candlesLit[4]:
		var numerator : float = log(GVars.spinData.rotations) * GVars.spinData.density
		var denominator : float = GVars.ritualData.rotBuff * (GVars.spinData.rotations * 100)
		GVars.ritualData.rotBuff += numerator / denominator * _sign
	
	# Gain rotation.
	var amount : float = float(wheelRotation / FULL_ROTATION_RADIANS)  # Usually a value of 1, since rotation resets at 2*PI.
	GVars.spinData.rotations += amount
	
	# Make rust progress for rotateWheel().
	GVars.rustData.threshProgress += amount
	
	# Signal rotation completed. Note: Some other scripts will need wheelRotation, so don't change wheelRotation before signalling.
	wheelRotationCompleted.emit()
	
	# Reset rotation.
	wheelRotation = fmod(wheelRotation, FULL_ROTATION_RADIANS)


func _calculateThreshProgress() -> float:
	var result : float = GVars.rustData.thresh
	return result


func _calculateThresh() -> float:
	var result : float = GVars.rustData.threshMult
	return result


func _calculateRust() -> float:
	# Base value for if there is a challenge.
	var result : float = 1.0
	
	# No calculations needed if doing the correct challenge.
	if GVars.hellChallengeNerf == 4:
		return result
	
	# Base value if there is not a challenge.
	result *= GVars.rustData.perThresh
	
	# Multiply value by any buff.
	result *= GlobalBuffs.rustGainModifier
	
	return result
