extends Automator
class_name Spinbot


#@ Public Variables


#@ Virtual Methods
func _execute() -> void:
	# Automator has to be enabled to execute.
	if not enabled:
		return
	
	# When executed, spins the wheel.
	WheelSpinner.spinWheel()


#@ Public Methods
func getType() -> String:
	return "Spinbot"
