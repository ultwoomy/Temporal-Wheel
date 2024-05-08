extends CharacterBody2D
var angle = 0
var speedDivisor = 0
var emoBuff = 1
var emoBuffSpeed = 1
var numOfCandles = 0.0
var fourthRustBuff = 1
var sigaugbuf = 1
@export var densityButton : Container
const RUST_PART = preload("res://Scenes/RustEmit.tscn")
signal oneClick

func update_wheel_sprite(frameno):
	if(GVars.sigilData.curSigilBuff == 2):
		sigaugbuf = 2
	if(GVars.curEmotionBuff == 1):
		emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
	elif(GVars.hellChallengeNerf == 1):
		emoBuffSpeed = 1.2 + ((log(GVars.spinData.rotations + 1)/85 - 1) * log(GVars.spinData.rotations + 1)/log(2))
	if(GVars.curEmotionBuff == 4):
		fourthRustBuff = GVars.rustData.fourth
	GVars.spinData.wheelphase = int(GVars.spinData.density)
	if(frameno > 11):
		self.get_node("Centerpiece").frame = 11
	else :
		self.get_node("Centerpiece").frame = frameno


func updateDivisor():
	GVars.spinData.wheelphase = int(GVars.spinData.density)
	update_wheel_sprite(GVars.spinData.wheelphase-1)
	
	
	# L.B: Utilizes my JSONReader class to load in a .json file intentionally written for this specific function.
	var wheelphase_json: Dictionary = JSONReader.new().load_json_file("res://JSON/WheelPhases.json")
	# (!) Hard-coded minimum and maximum for the range to match your previous code.
	var wheelphaseRange: Array = range(1, 12) # Note: range takes steps and stops before the second arg; first arg is inclusive, second arg is exclusive.
	if GVars.spinData.wheelphase in wheelphaseRange:
		for count in wheelphaseRange: 
			if GVars.spinData.wheelphase == count:
				# Use "count" as a way of finding a key in the JSON object "wheelphases".
				#	- Since count is an integer and a key has to be a string, change count as an integer into a string.
				#	- "wheelphases" is a JSON object that contains { "1":1000, "2":700, . . ., "other":80 }
				var wheelphase_index: int = wheelphase_json.wheelphases.keys().find(str(count))
				
				# If the string of the integer "count" is not a key in "wheelphases", then wheelphase_index will be -1 and thus not in range.
				if wheelphase_index == -1:
					speedDivisor = wheelphase_json.wheelphases.other
				else:
					# If the string of the integer "count" is a key within "wheelphases", then you can find that key and its value at index "wheelphase_index".
					# You can do it another way as well:
					#	- speedDivisor = wheelphase_json.wheelphases[str(count)]
					speedDivisor = wheelphase_json.wheelphases.values()[wheelphase_index]
	else:
		speedDivisor = wheelphase_json.wheelphases.other


func _process(_delta):
	if(calculateOneRot()):
		emit_signal("oneClick")
	if(GVars.rustData.threshProgress > GVars.rustData.thresh):
		if(GVars.curEmotionBuff == 4):
			emoBuff = log(GVars.spinData.rotations + 1) + 1
		if(GVars.hellChallengeNerf == 4):
			GVars.rustData.threshProgress -= GVars.rustData.thresh
			GVars.rustData.rust += 1
			GVars.rustData.thresh *= GVars.rustData.threshMult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(1)
			self.add_child(rus)	
		elif(GVars.sigilData.curSigilBuff == 1):
			GVars.rustData.threshProgress -= GVars.rustData.thresh
			GVars.rustData.rust += GVars.rustData.perThresh * 2 * emoBuff * fourthRustBuff
			GVars.rustData.thresh *= GVars.rustData.threshMult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(GVars.rustData.perThresh * 2 * emoBuff * fourthRustBuff)
			self.add_child(rus)
		else:
			GVars.rustData.threshProgress -= GVars.rustData.thresh
			GVars.rustData.rust += GVars.rustData.perThresh * emoBuff * fourthRustBuff
			GVars.rustData.thresh *= GVars.rustData.threshMult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(GVars.rustData.perThresh * emoBuff * fourthRustBuff)
			self.add_child(rus)	
	scale = Vector2(0.5 + log(GVars.spinData.size)/5,0.5 + log(GVars.spinData.size)/5)
func calculateOneRot():
	var changerot = 0.
	if(GVars.spinData.spin > 0):
		if(GVars.hellChallengeNerf == 1):
			changerot = (log(GVars.spinData.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) / emoBuffSpeed * GVars.ritualData.rotBuff
		else:
			changerot = (log(GVars.spinData.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) * emoBuffSpeed * GVars.ritualData.rotBuff
		if(GVars.ritualData.candlesLit[0]):
			rotation -= changerot
			angle -= changerot
		else:
			rotation += changerot
			angle += changerot
		if(angle < -2*PI):
			if(GVars.ritualData.candlesLit[2]):
				GVars.ritualData.ascBuff -= (log(GVars.rotations) * GVars.Aspinbuff)/(GVars.ritualData.ascBuff * (GVars.rotations * 10))
			if(GVars.ritualData.candlesLit[3]):
				GVars.rustData.rust -= 0.1
			if(GVars.ritualData.candlesLit[4]):
				GVars.ritualData.rotBuff -= (log(GVars.rotations) * GVars.density)/(GVars.ritualData.rotBuff * (GVars.rotations * 100))
			var temp = float(angle/(2*PI))
			GVars.spinData.rotations += temp
			GVars.rustData.threshProgress += temp
			angle = fmod(angle,(2*PI))
			if(GVars.curEmotionBuff == 1):
				emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
			GVars.spin += GVars.sucPerTick * GVars.rustData.increaseHunger * 5
		if(angle > 2*PI):
			if(GVars.ritualData.candlesLit[2]):
				GVars.ritualData.ascBuff += (log(GVars.spinData.rotations) * GVars.Aspinbuff)/(GVars.ritualData.ascBuff * (GVars.spinData.rotations * 5))
			if(GVars.ritualData.candlesLit[3]):
				GVars.rustData.rust += 0.1
			if(GVars.ritualData.candlesLit[4]):
				GVars.ritualData.rotBuff += (log(GVars.spinData.rotations) * GVars.spinData.density)/(GVars.ritualData.rotBuff * (GVars.spinData.rotations * 100))
			var temp = float(angle/(2*PI))
			GVars.spinData.rotations += temp
			if(GVars.sigilData.numberOfSigils[1]):
				GVars.mushroomData.pendingRots += temp * sigaugbuf
				if(GVars.ritualData.candlesLit[1]):
					GVars.mushroomData.xp += GVars.mushroomData.xpThresh/(50 * GVars.mushroomData.level)
			GVars.rustData.threshProgress += temp
			if(GVars.curEmotionBuff == 1):
				emoBuffSpeed = 1.2 + ((GVars.rustData.fourth - 1) * log(GVars.spinData.rotations + 1)/log(2))
			angle = fmod(angle,(2*PI))
			return true
	return false


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(0.5 + log(GVars.spinData.size)/5,0.5 + log(GVars.spinData.size)/5)
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))
	densityButton.densUp.connect(updateDivisor)
	numOfCandles = 0.0
	for n in GVars.ritualData.candlesLit.size():
		if(GVars.ritualData.candlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 0) and (GVars.sigilData.curSigilBuff == 5):
		numOfCandles -= 1
	if(numOfCandles > 5):
		numOfCandles = 5
	updateDivisor()


