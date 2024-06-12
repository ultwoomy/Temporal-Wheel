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


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signals
	spinButton.button.pressed.connect(WheelSpinner.spinWheel)
#	densityButton.densUp.connect(updateDivisor)
	GVars.spinData.wheelPhaseChanged.connect(wheel.updateWheelSprite)
	
	wheel.scale = Vector2(0.5 + log(GVars.spinData.size)/5, 0.5 + log(GVars.spinData.size)/5)
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))
	
	numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if (numOfCandles > 0) and (GVars.sigilData.curSigilBuff == 5):
		numOfCandles -= 1
	if (numOfCandles > 5):
		numOfCandles = 5
#	updateDivisor()


func _process(_delta):
	if calculateOneRot():
		growButton.suc_loop()
	
	# Rust related.
	if(GVars.rustData.threshProgress > GVars.rustData.thresh):
		# COMPLETED IN GlobalBuffs.gd
#		if(GVars.curEmotionBuff == 4):
#			emoBuff = log(GVars.spinData.rotations + 1) + 1
		
#		# COMPLETED IN GlobalBuffs.gd & WheelSpinner.gd
#		if(GVars.curEmotionBuff == 4):
#			fourthRustBuff = GVars.rustData.fourth

		if(GVars.hellChallengeNerf == 4):
			# COMPLETED IN GlobalBuffs.gd & WheelSpinner.gd
#			GVars.rustData.threshProgress -= GVars.rustData.thresh
#			GVars.rustData.rust += 1
#			GVars.rustData.thresh *= GVars.rustData.threshMult
			
			# COMPLETED IN RustEmitter.gd/WheelSpace scene/WheelSpaceWheel.gd
#			var rus = RUST_PART.instantiate()
#			rus.get_child(0).init(1)
#			self.add_child(rus)	
			pass
		elif(GVars.sigilData.curSigilBuff == 1):
			# COMPLETED IN GlobalBuffs.gd & WheelSpinner.gd
#			GVars.rustData.threshProgress -= GVars.rustData.thresh
#			GVars.rustData.rust += GVars.rustData.perThresh * 2 * emoBuff * fourthRustBuff
#			GVars.rustData.thresh *= GVars.rustData.threshMult
			
			# COMPLETED IN RustEmitter.gd/WheelSpace scene/WheelSpaceWheel.gd
#			var rus = RUST_PART.instantiate()
#			rus.get_child(0).init(GVars.rustData.perThresh * 2 * emoBuff * fourthRustBuff)
#			self.add_child(rus)
			pass
		else:
			# COMPLETED IN GlobalBuffs.gd & WheelSpinner.gd
#			GVars.rustData.threshProgress -= GVars.rustData.thresh
#			GVars.rustData.rust += GVars.rustData.perThresh * emoBuff * fourthRustBuff
#			GVars.rustData.thresh *= GVars.rustData.threshMult
			
			# COMPLETED IN RustEmitter.gd/WheelSpace scene/WheelSpaceWheel.gd
#			var rus = RUST_PART.instantiate()
#			rus.get_child(0).init(GVars.rustData.perThresh * emoBuff * fourthRustBuff)
#			self.add_child(rus)
			pass
	# COMPLETED IN WheelSpaceWheel.gd
#	wheel.scale = Vector2(0.5 + log(GVars.spinData.size)/5,0.5 + log(GVars.spinData.size)/5)


#@ Public Methods
func calculateOneRot() -> bool:
#	var changerot = 0.
	if(GVars.spinData.spin > 0):
		# COMPLETED IN WheelSpinner.gd
#		if(GVars.hellChallengeNerf == 1):
#			changerot = (log(GVars.spinData.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) / emoBuffSpeed * GVars.ritualData.rotBuff
#		else:
#			changerot = (log(GVars.spinData.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) * emoBuffSpeed * GVars.ritualData.rotBuff
		
		
		# COMPLETED IN WheelSpinner.gd
#		if(GVars.ritualData.candlesLit[0]):
#			wheel.rotation -= changerot
#			angle -= changerot
#		else:
#			wheel.rotation += changerot
#			angle += changerot
		
		# CHANGES ADDED TO MAKE USE OF WheelSpinner.gd
		# MOVED TO WheelSpaceWheel.gd
#		wheel.rotation = WheelSpinner.wheelRotation
#		angle = WheelSpinner.wheelRotation
		
		
		if(angle < -2*PI):  # Activated by candle that causes wheel to be spun backwards.
			# COMPLETED IN WheelSpinner.gd
#			if GVars.ritualData.candlesLit[2]:
#				GVars.ritualData.ascBuff -= (log(GVars.spinData.rotations) * GVars.Aspinbuff)/(GVars.ritualData.ascBuff * (GVars.spinData.rotations * 10))
#			if GVars.ritualData.candlesLit[3]:
#				GVars.rustData.rust -= 0.1
#			if GVars.ritualData.candlesLit[4]:
#				GVars.ritualData.rotBuff -= (log(GVars.spinData.rotations) * GVars.spinData.density)/(GVars.ritualData.rotBuff * (GVars.spinData.rotations * 100))
			
			# COMPLETED IN WheelSpinner.gd
#			var temp = float(angle/(2*PI))
#			GVars.spinData.rotations += temp
#			GVars.rustData.threshProgress += temp
			# COMPLETED IN WheelSpinner.gd
#			angle = fmod(angle,(2*PI))
			
			# COMPLETED IN WheelSpinner.gd
#			if(GVars.curEmotionBuff == 1):
#				emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
			
#			GVars.spinData.spin += GVars.sucPerTick * GVars.rustData.increaseHunger * 5
			pass
			
		if(angle > 2*PI):
			# COMPLETED IN WheelSpinner.gd
#			if GVars.ritualData.candlesLit[2]:
#				GVars.ritualData.ascBuff += (log(GVars.spinData.rotations) * GVars.Aspinbuff)/(GVars.ritualData.ascBuff * (GVars.spinData.rotations * 5))
#			if GVars.ritualData.candlesLit[3]:
#				GVars.rustData.rust += 0.1
#			if GVars.ritualData.candlesLit[4]:
#				GVars.ritualData.rotBuff += (log(GVars.spinData.rotations) * GVars.spinData.density)/(GVars.ritualData.rotBuff * (GVars.spinData.rotations * 100))
			
			# COMPLETED IN WheelSpinner.gd
#			var temp = float(angle/(2*PI))
#			GVars.spinData.rotations += temp
#			GVars.rustData.threshProgress += temp
			# COMPLETED IN WheelSpinner.gd
#			angle = fmod(angle,(2*PI))
			
			# COMPLETED IN MushroomGrower.gd
#			if(GVars.sigilData.numberOfSigils[1]):
#				GVars.mushroomData.pendingRots += temp * candleAugmentBuffModifier
#				if(GVars.ritualData.candlesLit[1]):
#					GVars.mushroomData.xp += GVars.mushroomData.xpThresh/(50 * GVars.mushroomData.level)
			
			
			# COMPLETED IN WheelSpinner.gd
#			if(GVars.curEmotionBuff == 1):
#				emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
			
			
			return true
	return false

'
TODO:
	APPLY CALCULATION CHANGES.
	Frame already changes, moved to WheelSpaceWheel.gd.
	
func updateWheelSprite(frameno):
	# COMPLETED IN GlobalBuffs.gd
	if(GVars.sigilData.curSigilBuff == 2):
		candleAugmentBuffModifier = 2
	
	# COMPLETED IN WheelSpinner.gd
	if(GVars.curEmotionBuff == 1):
		emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
	elif(GVars.hellChallengeNerf == 1):
		emoBuffSpeed = 1.2 + ((log(GVars.spinData.rotations + 1)/85 - 1) * log(GVars.spinData.rotations + 1)/log(2))
	
	# COMPLETED IN GlobalBuffs.gd
	if(GVars.curEmotionBuff == 4):
		fourthRustBuff = GVars.rustData.fourth
	
	# COMPLETED IN WheelSpaceWheel.gd
	GVars.spinData.wheelPhase = int(GVars.spinData.density)
	if(frameno > 11):
		wheel.centerpiece.frame = 11
	else :
		wheel.centerpiece.frame = frameno
'
'
func updateDivisor() -> void:
	# COMPLETED IN GVars.spinData IN density VARIABLE.
	GVars.spinData.wheelPhase = int(GVars.spinData.density)
#	updateWheelSprite(GVars.spinData.wheelphase-1)
	
	# L.B: Utilizes my JSONReader class to load in a .json file intentionally written for this specific function.
	var wheelPhaseJSON : Dictionary = JSONReader.new().loadJSONFile("res://JSON/WheelPhases.json")
	var wheelPhaseIndexOffset : int = GVars.spinData.wheelPhase - 1
	if wheelPhaseIndexOffset >= wheelPhaseJSON["rotationSpeedDivisor"].size():
		speedDivisor = wheelPhaseJSON["rotationSpeedDivisor"][wheelPhaseJSON["rotationSpeedDivisor"].size()]
	elif wheelPhaseIndexOffset < 0:
		speedDivisor = wheelPhaseJSON["rotationSpeedDivisor"][0]
	else:
		speedDivisor = wheelPhaseJSON["rotationSpeedDivisor"][wheelPhaseIndexOffset]
'
