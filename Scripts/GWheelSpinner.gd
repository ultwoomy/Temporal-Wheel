extends Node
# Autoload script.
# Runs calculations for wheel-related things.


#@ Signals
signal spinValueChanged(incrementValue : float)
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
		if value <= -1:
			_sign = -1
		else:
			_sign = 1


#@ Virtual Methods
func _process(_delta: float) -> void:
	rotateWheel()


#@ Public Methods
func spinWheel(reverse: bool = false) -> void:
	var incrementValue : float
	if not reverse:
		incrementValue = _calculateSpinGain()
		GVars.spinData.spin += incrementValue
	else:
		incrementValue = GVars.sucPerTick * GVars.rustData.increaseHunger * 5
		GVars.spinData.spin += incrementValue
	spinValueChanged.emit(incrementValue)


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
		if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
			GVars.sand += 1
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
	# Apply fearcat buff if applicable
	if not GVars.ifFirstFearcatNight:
		result *= GVars.fearcatData.fearcatBuffNight
	
	# Hell Challenge 0 effect
	if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY) and GVars.spinData.rotations > 1000:
		result /= (5000 + GVars.spinData.rotations)/6000
	
	## Brave Challenge: After the Player has reached 1000 rotation currency, increase the speed of the wheel.
	##  - Otherwise, 
	if GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE):
		if GVars.spinData.rotations <= 1000:
			result *= GVars.spinData.rotations/500 + 1
		else:
			result *= GVars.spinData.rotations/(log(GVars.spinData.rotations)/log(1.05)) + 1
	return result

#@ Private Methods
func _calculateSpinGain() -> float:
	# Base result Player gets from spinning the wheel with a click.
	var result : float = GVars.spinData.spinPerClick
	# Multiply the result by the size of the wheel.
	if GVars.hasChallengeActive(GVars.CHALLENGE_SHARP):
		result *= pow(GVars.spinData.size,0.5)/log(GVars.spinData.rotations + 2)/2
	elif GVars.curEmotionBuff == 2:
		result *= pow(GVars.spinData.size,GVars.spinData.density + 1)
	else:
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
		result *= GVars.rustData.fourth
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
	#spinWheel()  # Should I really have this func be called "spinWheel()"?
	
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
	GVars.spinData.rotations += amount * (GVars.kbityData.kbityLevel + 2 / 2)
	
	# Update fearcat buffs
	# Find ratio
	var ratio = 1
	if GVars.fearcatData.bankedNightRots <= GVars.fearcatData.bankedDayRots:
		ratio = ((GVars.fearcatData.bankedNightRots + 4)/ (GVars.fearcatData.bankedDayRots + 1))/4
	else:
		ratio = ((GVars.fearcatData.bankedDayRots + 4)/ (GVars.fearcatData.bankedNightRots + 1))/4 + 0.75
	if GVars.ifSecondBoot % 4 == 3 or GVars.ifSecondBoot % 4 == 0:
		GVars.fearcatData.bankedNightRots += amount * (GVars.kbityData.kbityLevel + 2 / 2)
		GVars.fearcatData.fearcatBuffNight = 1 + (GVars.fearcatData.bankedNightRots * GVars.Aspinbuff/50000) * ratio
	else:
		GVars.fearcatData.bankedDayRots += amount * (GVars.kbityData.kbityLevel + 2 / 2)
		GVars.fearcatData.fearcatBuffDay = GVars.fearcatData.bankedDayRots * GVars.Aspinbuff/3500 * ratio
	
	# Make rust progress for rotateWheel().
	GVars.rustData.threshProgress += amount
	
	GlobalBuffs.applyEmotionBuffs()
	
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
	if GVars.hasChallengeActive(GVars.CHALLENGE_CALM):
		return result
	
	# Base value if there is not a challenge.
	result *= GVars.rustData.perThresh
	
	# Multiply value by any buff.
	result *= GlobalBuffs.rustGainModifier
	
	return result
