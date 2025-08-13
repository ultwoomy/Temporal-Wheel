extends Node2D
class_name Packsmith


#@ Constants



#@ Public Variables
var state : PacksmithState


#@ Virtual Methods
func _ready() -> void:
	var newState : PacksmithState
	if GVars.ifFirstPack:
		newState = PacksmithPeakState.new(self)
	else:
		newState = PacksmithDefaultState.new(self)
	changeState(newState)


func changeState(newState : PacksmithState) -> void:
	if state:
		state._exit()
	state = newState
	state._enter()
