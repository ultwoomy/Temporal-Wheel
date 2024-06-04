extends Node
# Autoload script.
# Runs calculations for wheel-related things.


#@ Signals
signal wheelSpun


#@ Constants
const FULL_ROTATION_DEGREES : float = 2*PI


#@ Public Variables
var automators : Array[AutomatorData]  # Probably move to its own global script
var wheelRotation : float = 0.0  # Needed so that the Player doesn't have to be in WheelSpace scene for wheel to rotate.


#@ Virtual Methods
func _process(delta: float) -> void:
	rotateWheel()


#@ Public Methods
func spinWheel() -> void:
	GVars.spinData.spin += _calculateSpinGain()


func rotateWheel() -> void:
	# Reset rotation
	if abs(wheelRotation) > FULL_ROTATION_DEGREES:
		_completeRotation()
	
	# No spins then no rotating the wheel.
	if GVars.spinData.spin <= 0:
		return
	
	# Rotate wheel in a direction based on the candle lit(?)
	if GVars.ritualData.candlesLit[0]:
		# The angle of the wheel doesn't matter except for the sprite itself.
		wheelRotation -= getWheelRotationAmount()
	else:
		wheelRotation += getWheelRotationAmount()

'
# COMPLETED IN GVars.spinData IN density VARIABLE.
func updateDivisor() -> void:
	GVars.spinData.wheelPhase = int(GVars.spinData.density)
'

# Probably move this in WheelSpaceWheel(?), or a script that is global.
func getWheelRotationAmount() -> float:
	var value : float = log(GVars.spinData.spin)/log(2)
	# Divide by the speed divisor, which is based off the wheel phase.
	value /= _getRotationSpeedDivisor()
	# Reduce amount by the amount of lit candles .
	# (!) WIP: Have a global script that keeps track of buffs, and a script that keeps track of debuffs
	var numOfLitCandles : int = 0
	for boolean in GVars.ritualData.candlesLit:
		if boolean:
			numOfLitCandles += 1
	value *= 1 - (0.2 * numOfLitCandles)
	# Reduce/Increase amount based on the emotion buff from ascension.
	# (?) There must be something I can do with buff/debuff calculations.
	var emotionBuffSpeed : float = 1.0
	if GVars.curEmotionBuff == 1:
		# Increase
		emotionBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
		value *= emotionBuffSpeed
	elif GVars.hellChallengeNerf == 1:
		# Decrease
		emotionBuffSpeed = 1.2 + ((log(GVars.spinData.rotations + 1)/85 - 1) * log(GVars.spinData.rotations + 1)/log(2))
		value /= emotionBuffSpeed
	# Increase amount by rot buff.
	value *= GVars.ritualData.rotBuff
	return value



#@ Private Methods
func _calculateSpinGain() -> float:
	# Base value Player gets from spinning the wheel with a click.
	var value : float = GVars.spinData.spinPerClick
	# Multiply the value by the size of the wheel.
	value *= GVars.spinData.size
	# Multiply the value by the density of the wheel.
	value *= GVars.spinData.density
	# Multiply the value by the rust purchasable upgrade, increase spin.
	value *= GVars.rustData.increaseSpin
	# Multiply the value by the buffs granted by growing mushrooms.
	value *= GVars.mushroomData.spinBuff
	# Multiply the value by the buff granted by ascension(?).
	value *= GVars.Aspinbuff
	
	# Multiply the value by the buff granted by emotion(?) from ascension(?).
	if GVars.curEmotionBuff == 4:
		# Note: This is the same as "value *= GVars.rustData.fourth", but was written similar to this in previous code.
		var emotionBuffMultiplier: float = GVars.rustData.fourth
		value *= emotionBuffMultiplier
	return value


# L.B: Utilizes my JSONReader class to load in a .json file intentionally written for this specific function.
func _getRotationSpeedDivisor() -> float:
	var value : float
	var wheelPhaseJSON : Dictionary = JSONReader.new().loadJSONFile("res://JSON/WheelPhases.json")
	var wheelPhaseIndexOffset : int = GVars.spinData.wheelPhase - 1
	
	if wheelPhaseIndexOffset >= wheelPhaseJSON["rotationSpeedDivisor"].size():
		value = wheelPhaseJSON["rotationSpeedDivisor"][wheelPhaseJSON["rotationSpeedDivisor"].size() - 1]
	elif wheelPhaseIndexOffset < 0:
		value = wheelPhaseJSON["rotationSpeedDivisor"][0]
	else:
		value = wheelPhaseJSON["rotationSpeedDivisor"][wheelPhaseIndexOffset]
	return value


func _completeRotation() -> void:
	# Gain spin.
	spinWheel()  # Should I really have this func be called "spinWheel()"?
	
	# Gain rotation. Make progress towards getting rust.
	var amount : float = float(wheelRotation / FULL_ROTATION_DEGREES)  # Usually a value of 1, since rotation resets at 2*PI.
	GVars.spinData.rotations += amount
	GVars.rustData.threshProgress += amount
	
	# Reset rotation.
	wheelRotation = fmod(wheelRotation, FULL_ROTATION_DEGREES)
