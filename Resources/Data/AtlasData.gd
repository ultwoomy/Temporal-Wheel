extends Resource
class_name AtlasData

@export var dumpRustProg : float
@export var dumpRustThresh : float
@export var dumpRustScaling : float
@export var dumpRustMilestone : int
#shrugged = hell naw, terrible book

func resetData() -> void:
	dumpRustProg = 0
	dumpRustThresh = 1000
	#multiplicative scaling
	dumpRustScaling = 5
	dumpRustMilestone = 0
