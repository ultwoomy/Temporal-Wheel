extends Resource
class_name AutomatorData
# Data for creating an automator.


#@ Enumerators
enum Automators {
	SPINBOT,
	Mushroombot,
	RUSTBOT,
	VOIDBOT,
}


#@ Export Variables
@export var name: String
@export var automator: Automators
@export var level: int = 1			# default value
@export var amount: int = 1			# default value
@export var cooldown: float = 1.0	# default value
