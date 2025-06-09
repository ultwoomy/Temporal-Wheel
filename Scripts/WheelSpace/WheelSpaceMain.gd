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

var menuState : WS_MenuState


#@ Onready Variables
@onready var wheel : WheelSpaceWheel = $Wheel
@onready var spinButton : WheelSpaceSpinButton = $SpinButton
@onready var growButton : WheelSpaceGrowButton = $GrowButton
@onready var densityButton : WheelSpaceDensityButton = $DensButton
@onready var backpack : BackpackPanel = $BackpackPanel
@onready var challengesButton : TextureButton = $ChallengesButton
@onready var travelButton : Button = $TravelButton
var bb = load("res://Scenes/BleedBar.tscn").instantiate()

@onready var spinAmountLabel : Label = $SpinAmountLabel
@onready var rotationAmountLabel : Label = $RotationAmountLabel

@onready var challengeManager : ChallengeManager = $ChallengeManager


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var d = AutomatorData.new()
	#d.setAutomator("Spinbot")
	#Automation.addAutomatorFromData(d)
	
	# Set variables.
	menuState = WS_MenuState.new(self)
	
	# Connect signals
	spinButton.button.pressed.connect(WheelSpinner.spinWheel)
	GVars.spinData.wheelPhaseChanged.connect(wheel.updateWheelSprite)
	GVars.spinData.momentumValueChanged.connect(self.updateSpinAmountText.unbind(1))
	WheelSpinner.wheelRotationCompleted.connect(self.updateRotationValueText)
	EventManager.challenge_lost_L2.connect(self.checkBleedBar)
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))
	EventManager.tutorial_travel_found.connect(self.checkTutorial)
	if GVars.ifFirstBoot and GVars.sigilData.acquiredSigils.is_empty() and GVars.spinData.density < 2:
		travelButton.hide()
	challengesButton.pressed.connect(_onChallengesButtonPressed)
	
	# Display currency.
	updateSpinAmountText()
	updateRotationValueText()
	if(GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS)):
		self.add_child(bb)
	checkBleedBar()
	
	numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 0) and (GVars.sigilData.curSigilBuff == 4):
		numOfCandles -= 1
	if (numOfCandles > 5):
		numOfCandles = 5
	
	backpack.hide()
	Challenger.refresh()


func _process(_delta : float) -> void:
	if menuState:
		menuState._update(_delta)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:  # Exit out of menu using ESCAPE key.
			changeMenuState(WS_MenuState.new(self))


#@ Public Methods
func checkBleedBar():
	if not GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS) and bb != null:
		bb.queue_free()


func updateSpinAmountText() -> void:
	spinAmountLabel.text = str(GVars.getScientific(GVars.spinData.momentum))


func updateRotationValueText() -> void:
	if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY) and GVars.spinData.rotations > 1000:
		rotationAmountLabel.text = "The sands of time erode your wheel\n" + str("Rotations: ",GVars.getScientific(GVars.spinData.rotations))
	elif GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE) and GVars.spinData.rotations < 1000:
		rotationAmountLabel.text = "Something will happen at 1000 rotations...\n" + str("Rotations: ",GVars.getScientific(GVars.spinData.rotations))
	elif GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE) and GVars.spinData.rotations >= 1000:
		rotationAmountLabel.text = "Maximum Overdrive!\n" + str("Rotations: ",GVars.getScientific(GVars.spinData.rotations))
	else:
		rotationAmountLabel.text = str("Rotations: ",GVars.getScientific(GVars.spinData.rotations))


func changeMenuState(newMenuState : WS_MenuState) -> void:
	if menuState:
		menuState._exit()
	menuState = newMenuState
	menuState._enter()


#@ Private Methods
func _onSettingButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.SETTINGS)


func _onBackpackButtonPressed() -> void:
	if backpack.is_visible_in_tree():
		backpack.hide()
	else:
		backpack.show()


func _onChallengesButtonPressed() -> void:
	if menuState:
		if menuState is WS_MenuChallengesState:  # If already in the Challenges menu, then close it.
			changeMenuState(WS_MenuState.new(self))
			return
	changeMenuState(WS_MenuChallengesState.new(self))  # Otherwise, open the Challenges menu.


func _onTravelButtonPressed() -> void:
	if GVars.ifFirstBoot:
		GVars.ifFirstBoot = false
	SceneHandler.changeSceneToFilePath(SceneHandler.TRAVELSPACE)

func checkTutorial():
	if GVars.spinData.density > 1:
		travelButton.show()
		EventManager.tutorial_travel_found.disconnect(self.checkTutorial)
