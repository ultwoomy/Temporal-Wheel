extends Resource
class_name RitualData

@export var candlesLit : Array[bool]
@export var ascBuff : float
@export var rotBuff : float


# (!) Testing this out. Could override save? Not sure if I should do this for every data class or if this isn't necessary.
func _init() -> void:
	candlesLit = [false,false,false,false,false,false]
	ascBuff = 1
	rotBuff = 1


func resetData() -> void:
	candlesLit = [false,false,false,false,false,false]
	ascBuff = 1
	rotBuff = 1
