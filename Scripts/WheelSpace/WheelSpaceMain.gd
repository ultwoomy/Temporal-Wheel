extends CharacterBody2D
var angle = 0
var emoBuff = 1
var emoBuffSpeed = 1
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


func _process(_delta):
	var changerot = 0.0
	if(GVars.spin > 0):
		if(GVars.wheelphase == 1):
			changerot = (log(GVars.spin)/log(2))/1000
		elif(GVars.wheelphase == 2):
			changerot = (log(GVars.spin)/log(2))/600
		elif(GVars.wheelphase == 3):
			changerot = (log(GVars.spin)/log(2))/500
		elif(GVars.wheelphase == 4):
			changerot = (log(GVars.spin)/log(2))/450
		elif(GVars.wheelphase == 5):
			changerot = (log(GVars.spin)/log(2))/400
		elif(GVars.wheelphase == 6):
			changerot = (log(GVars.spin)/log(2))/350
		elif(GVars.wheelphase == 7):
			changerot = (log(GVars.spin)/log(2))/300
		elif(GVars.wheelphase == 8):
			changerot = (log(GVars.spin)/log(2))/250
		elif(GVars.wheelphase == 9):
			changerot = (log(GVars.spin)/log(2))/200
		elif(GVars.wheelphase == 10):
			changerot = (log(GVars.spin)/log(2))/150
		elif(GVars.wheelphase == 11):
			changerot = (log(GVars.spin)/log(2))/100
		elif(GVars.wheelphase == 12):
			changerot = (log(GVars.spin)/log(2))/80
		else:
			changerot = (log(GVars.spin)/log(2))/80
		rotation += changerot * emoBuffSpeed
		angle += changerot
		if(angle > 2*PI):
			var temp = float(angle/(2*PI))
			GVars.rotations += temp
			if(GVars.numberOfSigils > 1):
				GVars.SpendingRots += temp
			GVars.RthreshProg += temp
			angle = fmod(angle,(2*PI))
			emit_signal("oneClick")
			if(GVars.RthreshProg > GVars.Rthresh):
				if(GVars.curEmotionBuff == 4):
					emoBuff = log(GVars.rust) + 0.5
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
	update_wheel_sprite(GVars.wheelphase-1)


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(0.5 + log(GVars.size)/5,0.5 + log(GVars.size)/5)
	RenderingServer.set_default_clear_color(Color(0,0,0,1.0))


