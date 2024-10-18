extends Resource
class_name FearcatData

@export var bankedDayRots : float
@export var bankedNightRots : float
@export var hasBow : bool
@export var fearcatBuffDay : float
@export var fearcatBuffNight : float
func _init():
	resetData()

func resetData() -> void:
	bankedDayRots = 0
	bankedNightRots = 0
	hasBow = false
	fearcatBuffDay = 0
	fearcatBuffNight = 1
