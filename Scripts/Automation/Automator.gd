class_name Automator
# Abstract class for automators.
# Automator is an object, so it must be freed manually like Nodes.


#@ Public Variables
var enabled : bool


#@ Virtual Methods
# Runs the automator.
func _execute() -> void:
	pass

