extends Automator
class_name Spinbot
var angle = 0.0
var speedDivisor = 0.0
var numOfCandles = 0.0
var emoBuffSpeed = 0.0
var shouldSpin = true
var event_manager: EventManager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Upon creation, enable the automator.
	event_manager = get_tree().get_root().find_child("EventManager", true, false)
	event_manager.scene_change.connect(_check_scene)
	enabled = true
	updateDivisor()
	initialize()
	_automate()

func initialize():
	if(GVars.curEmotionBuff == 1):
		emoBuffSpeed = 1.2 + ((GVars.Rfourth - 1) * log(GVars.rotations)/log(2))
	else:
		emoBuffSpeed = 1
	numOfCandles = 0.0
	for n in GVars.RitCandlesLit.size():
		if(GVars.RitCandlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 5):
		numOfCandles = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (!enabled):
		return
	calculateOneRot()
		
func calculateOneRot():
	var changerot = 0.0
	if(GVars.spin > 0) and (shouldSpin):
		changerot = (log(GVars.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) * emoBuffSpeed * GVars.RitRotBuff
		angle += changerot
		if(angle > 2*PI):
			var temp = float(angle/(2*PI))
			GVars.rotations += temp
			if(GVars.numberOfSigils[1]):
				GVars.SpendingRots += temp
			GVars.RthreshProg += temp
			angle = fmod(angle,(2*PI))

func updateDivisor():
	GVars.wheelphase = int(GVars.density)
	if(GVars.wheelphase == 1):
		speedDivisor = 1000
	elif(GVars.wheelphase == 2):
		speedDivisor = 700
	elif(GVars.wheelphase == 3):
		speedDivisor = 600
	elif(GVars.wheelphase == 4):
		speedDivisor = 500
	elif(GVars.wheelphase == 5):
		speedDivisor = 400
	elif(GVars.wheelphase == 6):
		speedDivisor = 350
	elif(GVars.wheelphase == 7):
		speedDivisor = 300
	elif(GVars.wheelphase == 8):
		speedDivisor = 250
	elif(GVars.wheelphase == 9):
		speedDivisor = 200
	elif(GVars.wheelphase == 10):
		speedDivisor = 150
	elif(GVars.wheelphase == 11):
		speedDivisor = 100
	elif(GVars.wheelphase == 12):
		speedDivisor = 80
	else:
		speedDivisor = 80
#func _init(_automator_data: AutomatorData) -> void:
#	super._init(_automator_data)


func _automate() -> void:
	# Must be enabled to continue _automate.
	if (!enabled):
		return
	# Find any node (preferably "EventManager") with the name "EventManager".
	event_manager = get_tree().get_root().find_child("EventManager", true, false)
	if (event_manager):
		event_manager.wheel_spun.emit()
	await get_tree().create_timer(automator_data.cooldown).timeout
	updateDivisor()
	initialize()
	_automate()

func _check_scene(ifwheel) -> void:
	if(ifwheel == null):
		shouldSpin = true
		return
	if(ifwheel):
		shouldSpin = false
	else:
		shouldSpin = true
		
#	spinPerCDisplay.text = str(GVars.getScientific(GVars.spinPerClick))
#	await get_tree().create_timer(0.1).timeout
#	spin_update_loop()
