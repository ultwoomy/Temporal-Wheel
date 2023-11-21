extends CharacterBody2D
var angle = 0
var speedDivisor = 0
var emoBuff = 1
var emoBuffSpeed = 1
var numOfCandles = 0.0
@export var densityButton : Container
const RUST_PART = preload("res://Scenes/RustEmit.tscn")
signal oneClick

func update_wheel_sprite(frameno):
	if(GVars.curEmotionBuff == 1):
		emoBuffSpeed = 1.2
	GVars.wheelphase = int(GVars.density)
	if(frameno > 11):
		self.get_node("Centerpiece").frame = 11
	else :
		self.get_node("Centerpiece").frame = frameno

func updateDivisor():
	GVars.wheelphase = int(GVars.density)
	update_wheel_sprite(GVars.wheelphase-1)
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

func _process(_delta):
	if(calculateOneRot()):
		emit_signal("oneClick")
	if(GVars.RthreshProg > GVars.Rthresh):
		if(GVars.curEmotionBuff == 4):
			emoBuff = log(GVars.rust) + 1
		if(GVars.curSigilBuff == 1):
			GVars.RthreshProg -= GVars.Rthresh
			GVars.rust += GVars.Rperthresh * 2 * emoBuff
			GVars.Rthresh *= GVars.Rthreshmult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(GVars.Rperthresh * 2 * emoBuff)
			self.add_child(rus)
		else:
			GVars.RthreshProg -= GVars.Rthresh
			GVars.rust += GVars.Rperthresh * emoBuff
			GVars.Rthresh *= GVars.Rthreshmult
			var rus = RUST_PART.instantiate()
			rus.get_child(0).init(GVars.Rperthresh)
			self.add_child(rus)	
	scale = Vector2(0.5 + log(GVars.size)/5,0.5 + log(GVars.size)/5)

func calculateOneRot():
	var changerot = 0.0
	if(GVars.spin > 0):
		changerot = (log(GVars.spin)/log(2))/speedDivisor * (1-(0.2*numOfCandles)) * emoBuffSpeed * GVars.RitRotBuff
		if(GVars.RitCandlesLit[0]):
			rotation -= changerot
			angle -= changerot
		else:
			rotation += changerot
			angle += changerot
		if(angle < -2*PI):
			if(GVars.RitCandlesLit[2]):
				GVars.RitAscBuff += (GVars.rotations * GVars.Aspinbuff)/(GVars.RitAscBuff * (GVars.rotations + 500))
			if(GVars.RitCandlesLit[3]):
				GVars.rust += 0.1
			if(GVars.RitCandlesLit[4]):
				GVars.RitRotBuff += (GVars.rotations * GVars.density)/(GVars.RitRotBuff * (GVars.rotations + 1000))
			var temp = float(angle/(2*PI))
			GVars.rotations += temp
			GVars.RthreshProg += temp
			angle = fmod(angle,(2*PI))
			GVars.spin += GVars.sucPerTick * 5
		if(angle > 2*PI):
			if(GVars.RitCandlesLit[2]):
				GVars.RitAscBuff += (GVars.rotations * GVars.Aspinbuff)/(GVars.RitAscBuff * (GVars.rotations + 500))
			if(GVars.RitCandlesLit[3]):
				GVars.rust += 0.1
			if(GVars.RitCandlesLit[4]):
				GVars.RitRotBuff += (GVars.rotations * GVars.density)/(GVars.RitRotBuff * (GVars.rotations + 1000))
			var temp = float(angle/(2*PI))
			GVars.rotations += temp
			if(GVars.numberOfSigils[1]):
				GVars.SpendingRots += temp
				if(GVars.RitCandlesLit[1]):
					GVars.SpendingRots += temp
			GVars.RthreshProg += temp
			angle = fmod(angle,(2*PI))
			return true
	return false
# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(0.5 + log(GVars.size)/5,0.5 + log(GVars.size)/5)
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))
	densityButton.densUp.connect(updateDivisor)
	numOfCandles = 0.0
	for n in GVars.RitCandlesLit.size():
		if(GVars.RitCandlesLit[n]):
			numOfCandles += 1
	if(numOfCandles > 5):
		numOfCandles = 5
	updateDivisor()


