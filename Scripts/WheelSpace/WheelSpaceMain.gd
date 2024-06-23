extends GameScene
class_name WheelSpaceMain


#@ Signals


#@ Constants


#@ Export Variables


#@ Public Variables
var angle : float = 0.0
var speedDivisor : float = 1.0
var emoBuffSpeed : float = 1.0
var numOfCandles : int = 0
var fourthRustBuff : float = 1.0
var candleAugmentBuffModifier : float = 1.0


#@ Onready Variables
@onready var wheel : WheelSpaceWheel = $Wheel
@onready var spinButton : WheelSpaceSpinButton = $SpinButton
@onready var growButton : WheelSpaceGrowButton = $GrowButton
@onready var densityButton : WheelSpaceDensityButton = $DensButton
@onready var backpack : BackpackPanel = $BackpackPanel


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signals
#	var d = AutomatorData.new()
#	d.setAutomator("Spinbot")
#	Automation.addAutomatorFromData(d)
	
	spinButton.button.pressed.connect(WheelSpinner.spinWheel)
	GVars.spinData.wheelPhaseChanged.connect(wheel.updateWheelSprite)
	
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))
	
	numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 0) and (GVars.sigilData.curSigilBuff == 4):
		numOfCandles -= 1
	if (numOfCandles > 5):
		numOfCandles = 5
		
	backpack.hide()		


func _process(_delta):
	pass


func _on_backpack_button_pressed():
	if backpack.is_visible_in_tree():
		backpack.hide()
	else:
		backpack.show()
