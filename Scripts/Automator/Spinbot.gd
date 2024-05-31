extends Automator
class_name Spinbot


#@ Public Variables
var angle = 0.0
var speedDivisor = 0.0
var numOfCandles = 0.0
var emoBuffSpeed = 0.0
var shouldSpin = true


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Listen for signals.
	if not EventManager.scene_change.is_connected(_checkScene):
		EventManager.scene_change.connect(_checkScene)
	
	# Upon creation, enable the automator.
	enabled = true
	updateDivisor()
	initialize()
	_automate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (!enabled):
		return
	calculateOneRot()


#@ Public Methods
func initialize() -> void:
	if(GVars.hellChallengeNerf == 1):
		emoBuffSpeed = 1.2 + ((log(GVars.rotations + 1)/85 - 1) * log(GVars.rotations + 1)/log(2))
	elif(GVars.curEmotionBuff == 1):
		emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.rotations)/log(2))
	else:
		emoBuffSpeed = 1
	numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 5):
		numOfCandles = 5


func calculateOneRot() -> void:
	var changerot = 0.0
	if (GVars.spinData.spin > 0) and (shouldSpin):
		if(GVars.hellChallengeNerf == 1):
			changerot = (log(GVars.spinData.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) / emoBuffSpeed * GVars.ritualData.rotBuff
		else:
			changerot = (log(GVars.spinData.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) * emoBuffSpeed * GVars.ritualData.rotBuff
		angle += changerot
		if (angle > 2*PI):
			var temp = float(angle/(2*PI))
			GVars.spinData.rotations += temp
			if(GVars.sigilData.numberOfSigils[1]):
				GVars.mushroomData.pendingRots += temp
			GVars.rustData.threshProgress += temp
			angle = fmod(angle,(2*PI))


func updateDivisor() -> void:
	# WIP: Use WheelPhases.json instead of this else-if.
	GVars.spinData.wheelPhase = int(GVars.spinData.density)
	if(GVars.spinData.wheelPhase == 1):
		speedDivisor = 1000
	elif(GVars.spinData.wheelPhase == 2):
		speedDivisor = 700
	elif(GVars.spinData.wheelPhase == 3):
		speedDivisor = 600
	elif(GVars.spinData.wheelPhase == 4):
		speedDivisor = 500
	elif(GVars.spinData.wheelPhase == 5):
		speedDivisor = 400
	elif(GVars.spinData.wheelPhase == 6):
		speedDivisor = 350
	elif(GVars.spinData.wheelPhase == 7):
		speedDivisor = 300
	elif(GVars.spinData.wheelPhase == 8):
		speedDivisor = 250
	elif(GVars.spinData.wheelPhase == 9):
		speedDivisor = 200
	elif(GVars.spinData.wheelPhase == 10):
		speedDivisor = 150
	elif(GVars.spinData.wheelPhase == 11):
		speedDivisor = 100
	elif(GVars.spinData.wheelPhase == 12):
		speedDivisor = 80
	else:
		speedDivisor = 80


#@ Private Methods
func _automate() -> void:
	# Must be enabled to continue _automate.
	if not enabled:
		return
	
	EventManager.wheel_spun.emit()
	await get_tree().create_timer(automator_data.cooldown).timeout
	updateDivisor()
	initialize()
	_automate()


func _checkScene(ifwheel) -> void:
	if(GVars.curEmotionBuff == 1):
		emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.rotations + 1)/log(2))
	if(ifwheel == null):
		shouldSpin = true
		return
	shouldSpin = !ifwheel
