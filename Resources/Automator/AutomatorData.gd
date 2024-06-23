extends Resource
class_name AutomatorData
# Data for creating an automator.


#@ Enumerators
enum Automators {
	SPINBOT,
	MUSHBOT,
	RUSTBOT,
	VOIDBOT,
}


#@ Export Variables
@export var name: String
@export var automator: Automators
@export var level: int = 1			# default value
@export var amount: int = 1			# default value
@export var cooldown: float = 1.0	# default value

func setAutomator(type : String):
	if type == "Spinbot":
		automator = Automators.SPINBOT
	elif type == "Mushbot":
		automator = Automators.MUSHBOT
	elif type == "Rustbot":
		automator = Automators.RUSTBOT
	elif type == "Voidbot":
		automator = Automators.VOIDBOT
	else:
		automator = Automators.SPINBOT
