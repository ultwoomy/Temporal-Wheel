extends Node
# Autoload script.


#@ Signals
signal wheelSpun


#@ Public Variables
var automators : Array[AutomatorData]


#@ Public Methods
func spinWheel() -> void:
	GVars.spinData.spin += _calculateSpinGain()


#@ Private Methods
func _calculateSpinGain() -> float:
	# Base value Player gets from spinning the wheel with a click.
	var value: float = GVars.spinData.spinPerClick
	
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
