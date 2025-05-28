extends Node
class_name VoidSpaceCurrencyUI


#@ Constants


#@ Onready Variables
@onready var currencyLabel : Label = $CurrencyLabel


#@ Virtual Methods
func _ready() -> void:
	displayCurrency()
	
	#@ Listen for signals.
	WheelSpinner.spinValueChanged.connect(displayCurrency)


#@ Public Methods
func displayCurrency() -> void:
	# Setup.
	var linesOfText : Array[String] = [
		"Momentum: " + str(GVars.getScientific(GVars.spinData.spin)) + "\n",
		"Rotations: " + str(GVars.getScientific(GVars.spinData.rotations)) + "\n",
		"Rust: " + str(GVars.getScientific(GVars.rustData.rust)) + "\n",
	]
	currencyLabel.text = ""
	
	# Display text.
	for string in linesOfText:
		currencyLabel.text += string
