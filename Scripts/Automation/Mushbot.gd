extends Automator
class_name Mushbot


#@ Public Variables


#@ Virtual Methods
func _execute() -> void:
	# Automator has to be enabled to execute.
	if not enabled:
		return

func getType() -> String:
	return "Mushbot"