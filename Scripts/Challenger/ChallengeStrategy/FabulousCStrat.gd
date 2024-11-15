extends ChallengeStrategy
class_name FabulousCStrat


#@ Constants
const MAXIMUM_HEALTH : int = 160
const MAXIMUM_BLEED_STACKS : int = 4


#@ Public Variables
var healthBar : Node



#@ Virtual Methods
func _execute() -> void:
	null
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


func _resurge() -> void:
	if GVars.bleedstacks < MAXIMUM_BLEED_STACKS:
		GVars.health = MAXIMUM_HEALTH
		GVars.bleedstacks += 1
		print("huh" + str(GVars.bleedstacks))
		EventManager.emit_signal("bleedstacks_changed")
	else:
		print("RIP, you died and lost the challenge.")
		GVars.resetChallengeVars()
		SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
		EventManager.emit_signal("disconnect_thorns")
		EventManager.emit_signal("challenge_lost_L2")
		GVars.challengesFailed += 1
		
