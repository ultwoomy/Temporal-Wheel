extends ChallengeComponent
class_name FabulousCComp


#@ signals
signal thornyButtonDamageResolved(damage: int)


#@ Export Variables
@export var damage : int = 1
@export var level : int = 1  # Levels indicate at which bleed stacks should this component be enabled. 0 being no bleed stacks.
@export var sprite : Sprite2D


#@ Public Variables
func _ready():
	# Error checking.
	if not sprite:
		printerr("ERROR: Fabulous challenge component does not have a sprite assigned to it in parent, ", self.get_parent(), "!")
	checkIfEnabled()
	EventManager.bleedstacks_changed.connect(self.checkIfEnabled)


#@ Public Methods
# FabulousChallengeComponent must be in a container alongside a button in order for this method to be called when the button is pressed.
func onThornyButtonPressed() -> void:
	if GVars.bleedstacks >= level and GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS):
		thornyButtonDamageResolved.emit(damage)

func checkIfEnabled():
	if GVars.bleedstacks >= level and GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS):
		sprite.show()
	else:
		sprite.hide()
