extends ChallengeComponent
class_name FabulousCComp


#@ signals
signal thornyButtonDamageResolved(damage: int)


#@ Export Variables
@export var damage : int = 1
@export var level : int = 1  # Levels indicate at which bleed stacks should this component be enabled. 1 being no bleed stacks.


#@ Public Variables


#@ Public Methods
# FabulousChallengeComponent must be in a container alongside a button in order for this method to be called when the button is pressed.
func onThornyButtonPressed() -> void:
	thornyButtonDamageResolved.emit(damage)
