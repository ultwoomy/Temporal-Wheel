class_name Automator
# Abstract class for automators.
# Automator is an object, so it must be freed manually like Nodes.


#@ Public Variables
var enabled : bool  # If enabled, then the Automator can execute.
var cooldown : float  # If not <= 0 then Automator can not execute.


#@ Virtual Methods
# Runs the automator.
func _execute() -> void:
	pass

