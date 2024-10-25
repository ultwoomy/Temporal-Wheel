extends ChallengeStrategy
class_name FabulousCStrat


#@ Constants
const MAXIMUM_HEALTH : int = 1
const MAXIMUM_BLEED_STACKS : int = 6


#@ Public Variables
var health : int = 1
var healthBar : Node
var bleedStacks : int = 0


#@ Virtual Methods
func _execute() -> void:
	healthBar = _createHealthbar()
	# TODO:
	#  - Create a health bar script.
	#  - Connect signals from the health bar script to this script.
	#  - Determine what to do if health bar reaches 0.
	#  - 


#@ Public Methods
func applyDamage(amount : int) -> void:
	health -= amount
	# TODO:
	#  - Have health bar display update.
	print("Health took ", amount, " of damage! Now it is at ", health, "!")
	if health <= 0:
		_resurge()


#@ Private Methods
func _createHealthbar() -> Node:
	print("Create health bar in FabulousCS.gd!")
	return null


func _resurge() -> void:
	if bleedStacks < MAXIMUM_BLEED_STACKS:
		health = MAXIMUM_HEALTH
		bleedStacks += 1
	else:
		print("RIP, you died and lost the challenge.")
