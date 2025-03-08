extends Node
# Global Script


#@ Public Variables
var automators : Array[]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WheelSpinner.wheelRotationCompleted.connect(automate)
	for x in GVars.automatorVarsData.automatorList:
		addAutomatorFromData(x)


#@ Public Methods
# Runs through the array of automators and execute them.
func automate() -> void:
	# Make sure there are any automators.
	if not automators:
		return
	# If there are any automators, make them execute.
	for automator in automators:
		if automator.enabled:
			automator._execute()


func contains(what : String) -> bool:
	for x in automators:
		if x.getType() == what:
			return true
	return false


func updateActive() -> void:
	for x in GVars.automatorVarsData.automatorList:
		if not contains(x.name):
			initAutomatorFromType(x.name)


func initAutomatorFromType(x) -> void:
	var d = AutomatorData.new()
	d.setAutomator(x)
	Automation.addAutomatorFromData(d)


# Add an automator to the array using AutomatorData.
func addAutomatorFromData(automatorData : AutomatorData) -> void:
	var newAutomator : Automator = _createAutomatorFromData(automatorData)
	automators.append(newAutomator)


#@ Private Methods
func _createAutomatorFromData(automatorData : AutomatorData) -> Automator:
	# Local Variables
	var result : Automator
	
	# Create the correct Automator.
	match automatorData.automator:
		AutomatorData.Automators.SPINBOT:
			result = Spinbot.new()
		AutomatorData.Automators.MUSHBOT:
			result = Mushbot.new()
		AutomatorData.Automators.VOIDBOT:
			result = Voidbot.new()
		AutomatorData.Automators.RUSTBOT:
			result = Rustbot.new()
	result.enabled = true
	return result
	
func clearAutomators():
	automators.clear()
