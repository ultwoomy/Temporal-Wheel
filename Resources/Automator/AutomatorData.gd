extends Resource
class_name AutomatorData

enum Automators {
	Spinbot,
	Mushroombot,
	Rustbot,
	Voidbot,
}


@export var name: String
@export var automator: Automators
@export var level: int = 1			# default value
@export var amount: int = 1			# default value
@export var cooldown: float = 1.0	# default value

