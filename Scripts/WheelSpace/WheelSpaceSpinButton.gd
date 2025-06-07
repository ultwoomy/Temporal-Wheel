extends GameButton
class_name WheelSpaceSpinButton


#@ Signals


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")


#@ Onready Variables
@onready var spinPerClickDisplay : Label = $SpinPerClickDisplay
@onready var button : Button = $SpinButton
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent  # Optional


#@ Virtual Methods
func _ready():
	_spinUpdateLoop()
	##
	## save DISABLED FOR TESTING!
	##
	#_saveLoop()
	# L.B: Since clicking on the button adds to spin, this can be kept here.
	# ...However, you can also have it in its own script w/ the function
	# ...OR have the button call the function here.
	# ...OR have the button signal to somewhere to add to spin (so other things can add to it as well)
	button.pressed.connect(self._onButtonPressed)


#@ Private Methods
func _onButtonPressed():
	# Tell EventManager that wheel has been spun, which will apply calculations and spin currency.
	EventManager.wheel_spun.emit()
	playAnimation(GameButtonPopAnimation.new(self))
	_spinUpdateLoop()
	_displayIncrementValue(WheelSpinner.incrementAmount)
	


func _spinUpdateLoop():
	if(GVars.hasChallengeActive(GVars.CHALLENGE_SHARP)):
		GVars.spinData.momentumPerClick = 1.5/(log(GVars.spinData.momentum + 2)/2)
	elif GVars.soulsData.spinBaseBuffEnabled:
		GVars.spinData.momentumPerClick = 1 + log(GVars.spinData.rotations + 1)/log(10 - GVars.soulsData.spinBaseBuff)
	else:
		GVars.spinData.momentumPerClick = 1
	spinPerClickDisplay.text = str(GVars.getScientific(GVars.spinData.momentumPerClick))


func _saveLoop():
	GVars.save_prog()
	await get_tree().create_timer(20).timeout
	_saveLoop()


func _displayIncrementValue(value : float) -> void:
	var incrementLabel : IncrementLabel = createIncrementLabel(value)
	
	# Reposition the increment value label at the mouse position.
	var mousePosition : Vector2 = get_global_mouse_position()
	incrementLabel.position = mousePosition - (incrementLabel.size / 2.0)
