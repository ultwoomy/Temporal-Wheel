extends Resource
class_name AtlasData

@export var dumpRustProg : float
@export var dumpRustThresh : float
@export var dumpRustScaling : float
@export var dumpRustMilestone : int
@export var hasReset : bool
#shrugged = hell naw, terrible book

func _init():
	resetData()
	
func resetData() -> void:
	dumpRustProg = 0
	dumpRustThresh = 300
	#multiplicative scaling
	dumpRustScaling = 4
	dumpRustMilestone = 0
	hasReset = false
