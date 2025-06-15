extends Node
class_name IntroTutorial


#@ Virtual Methods
func _ready() -> void:
	
	# Next, wait for density value to change
	await GVars.spinData.densityValueChanged
	print("Hello?")


#@ Private Methods
