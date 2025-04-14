extends Resource
class_name RitualData


@export var candlesLit : Array[bool]
@export var totalLitCandles : int :
	get():
		var result : int = 0
		for candle in candlesLit:
			if candle:
				result += 1
		
		if (result > 0) and (GVars.sigilData.curSigilBuff == 4):
			result -= 1
		elif (result > 5):
			result = 5
		return result
@export var ascBuff : float
@export var rotBuff : float


# (!) Testing this out. Could override save? Not sure if I should do this for every data class or if this isn't necessary.
func _init() -> void:
	resetData()


#@ Public Methods
func resetData() -> void:
	candlesLit = [false,false,false,false,false,false]
	ascBuff = 1
	rotBuff = 1
