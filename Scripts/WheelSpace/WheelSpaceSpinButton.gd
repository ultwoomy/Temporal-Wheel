extends Control
class_name WheelSpaceSpinButton


#@ Signals


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")


#@ Onready Variables
@onready var spinPerClickDisplay : Label = $SpinPerClickDiplay
@onready var button : Button = $SpinButton
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent  # Optional


#@ Virtual Methods
func _ready():
	_spinUpdateLoop()
	_saveLoop()
	# L.B: Since clicking on the button adds to spin, this can be kept here.
	# ...However, you can also have it in its own script w/ the function
	# ...OR have the button call the function here.
	# ...OR have the button signal to somewhere to add to spin (so other things can add to it as well)
	button.size = Vector2(200,100)
	button.text = "Spin"
	button.expand_icon = true
	button.pressed.connect(self._buttonPressed)
	await get_tree().create_timer(0.1).timeout


# L.B: Probably just use a signal in a different script so all things can add to spin.
func _buttonPressed():
	EventManager.wheel_spun.emit()
#	L.B: This line of code is being commented out since it isn't needed (since SpinDisplay has it in its _process() function)
#	...If you want to change the text only when necessary, use signals instead of assigning the Node to a variable.
#	...Ex: Call a signal when GVars.spin changes.
	_spinUpdateLoop()


#@ Private Methods
func _spinUpdateLoop():
	if(GVars.hasChallengeActive(GVars.CHALLENGE_SHARP)):
		GVars.spinData.spinPerClick = 1.5/(log(GVars.spinData.spin + 2)/2)
	elif GVars.soulsData.spinBaseBuffEnabled:
		GVars.spinData.spinPerClick = 1 + log(GVars.spinData.rotations + 1)/log(10 - GVars.soulsData.spinBaseBuff)
	else:
		GVars.spinData.spinPerClick = 1
	spinPerClickDisplay.text = str(GVars.getScientific(GVars.spinData.spinPerClick))


func _saveLoop():
	GVars.save_prog()
	await get_tree().create_timer(20).timeout
	_saveLoop()
