extends ChallengeStrategy
class_name FabulousCStrat


#@ Constants
const MAXIMUM_HEALTH : int = 160
const MAXIMUM_BLEED_STACKS : int = 6


#@ Public Variables
var healthBar : Node



#@ Virtual Methods
func _execute() -> void:
	healthBar = _createHealthbar()
	add_child(healthBar)
	# TODO:
	#  - Create a health bar script.
	#  - Connect signals from the health bar script to this script.
	#  - Determine what to do if health bar reaches 0.
	#  - 


#@ Public Methods
func applyDamage(amount : int) -> void:
	GVars.health -= amount
	# TODO:
	#  - Have health bar display update.
	print("Health took ", amount, " of damage! Now it is at ", GVars.health, "!")
	if GVars.health <= 0:
		_resurge()


#@ Private Methods
func _createHealthbar() -> Node:
	print("Create health bar in FabulousCS.gd!")
	var bb = load("res://Scenes/BleedBar.tscn").instantiate()
	return bb


func _resurge() -> void:
	if GVars.bleedstacks < MAXIMUM_BLEED_STACKS:
		GVars.health = MAXIMUM_HEALTH
		GVars.bleedstacks += 1
	else:
		print("RIP, you died and lost the challenge.")
