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
@onready var backpackPanel : BackpackPanel = $BackpackPanel

@onready var spinButton : WheelSpaceSpinButton = $SpinButton
@onready var growButton : WheelSpaceGrowButton = $GrowButton
@onready var densityButton : WheelSpaceDensityButton = $DensButton
@onready var settingsButton : BaseButton = $SettingsButton
@onready var backpackButton : BaseButton = $BackpackButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signals
	spinButton.button.pressed.connect(WheelSpinner.spinWheel)
	backpackButton.pressed.connect(_onBackpackButtonPressed)
	GVars.spinData.wheelPhaseChanged.connect(wheel.updateWheelSprite)
	
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))
	
	backpackPanel.hide()
	
	numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 0) and (GVars.sigilData.curSigilBuff == 4):
		numOfCandles -= 1
	if (numOfCandles > 5):
		numOfCandles = 5


func _process(_delta):
	pass


#@ Private Methods
func _onSettingsButtonPressed() -> void:
	pass


func _onBackpackButtonPressed() -> void:
	if backpackPanel.visible:  # Hide backpackPanel.
		backpackPanel.visible = false
	else:  # Show backpackPanel.
		backpackPanel.visible = true
