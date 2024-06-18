extends Node
# Global Script


#@ Public Variables
var automators : Array[Automator]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	automate()


#@ Public Methods
# Runs through the array of automators and execute them.
func automate() -> void:
	# Make sure there are any automators.
	if not automators:
		return
	
	# If there are any automators, make them execute.
	for automator in automators:
		if automator.enabled and (automator.cooldown <= 0):
			automator.execute()


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
	
	return result
