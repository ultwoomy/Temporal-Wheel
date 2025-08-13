extends Node2D
class_name Packsmith


#@ Constants



#@ Public Variables
var state : PacksmithState


#@ Virtual Methods
func _ready() -> void:
	var newState : PacksmithState
	if GVars.ifFirstPack:
		newState = PacksmithDefaultState.new(self)
	else:
		newState = PacksmithDefaultState.new(self)
	self.position = newState.STATE_POSITION
	self.rotation_degrees = newState.STATE_ROTATION_DEGREES
	changeState(newState)


func changeState(newState : PacksmithState) -> void:
	if state:
		state._exit()
	state = newState
	state._enter()
