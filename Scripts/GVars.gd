extends Node
@export_group("R0stats")
@export var spin : float
@export var spinPerClick : float
@export var size : float
@export var sucPerTick : float
@export var sucTresh : float
@export var curSucSize : float
@export var sizeRecord : float
@export var density : float
@export var sucPerTDens : float
@export var densTresh : float
@export var curSucDens : float
@export var wheelphase : int
@export var rotations : float

@export var rustData : RustData

@export var SmushLevel : float
@export var Sxp : float
@export var Sxpthresh : float
@export var Sxpthreshmult : float
@export var Scurrent : Array[int]
@export var StimeLeft : Array[float]
@export var SpendingRots : float
@export var Sspinbuff : float
@export var Sascbuff : float
@export var RitCandlesLit : Array[bool]
@export var RitAscBuff : float
@export var RitRotBuff : float
@export var sigilCostSpin : float
@export var sigilCostRot : float
@export var sigilCostSpinScale : float
@export var sigilCostRotScale : float
@export var numberOfSigils : Array[bool]
@export var curSigilBuff : int
@export_group("R1stats")
@export var curEmotionBuff : int
@export var Aspinbuff : float
@export var ifhell : bool
@export var ifheaven : bool
@export_group("PermStats")
@export var iffirstboot : bool
@export var iffirstvoid : bool
@export var iffirstpack : bool
var chars = 0
var loader = preload("res://Resources/SaveData.tres")
var fmat = preload("res://Scripts/FormatNo.gd")
func _init():
	#resetR0Stats()
	#resetR1Stats()
	#resetPermStats()
	#save_prog()
	load_as_normal()

func save_prog():
	loader.spin = spin
	loader.spinPerClick = spinPerClick
	loader.size = size
	loader.sucPerTick = sucPerTick
	loader.sucTresh = sucTresh
	loader.curSucSize = curSucSize
	loader.sizeRecord = sizeRecord
	loader.density = density
	loader.sucPerTDens = sucPerTDens
	loader.densTresh = densTresh
	loader.curSucDens = curSucDens
	loader.wheelphase = wheelphase
	loader.rotations = rotations
	
	# L.B: There may be a way of shortening the code in here.
	# (?) Could have the RustData class have a function in its class that does this exact thing. Weird to have that kind of function in its class though.
	# 
	loader.rustData = rustData
	loader.rust = rustData.rust
	loader.Rincreasespin = rustData.increaseSpin
	loader.RincreasespinCost = rustData.increaseSpinCost
	loader.RincreasespinScaling = rustData.increaseSpinScaling
	loader.Rincreasehunger = rustData.increaseHunger
	loader.RincreasehungerCost = rustData.increaseHungerCost
	loader.RincreasehungerScaling = rustData.increaseHungerScaling
	loader.Rincreaserust = rustData.increaseRust
	loader.RincreaserustCost = rustData.increaseRustCost
	loader.RincreaserustScaling = rustData.increaseRustScaling
	loader.Rfourth = rustData.fourth
	loader.RfourthCost = rustData.fourthCost
	loader.RfourthScaling = rustData.fourthScaling
	loader.Rthresh = rustData.thresh
	loader.Rperthresh = rustData.perThresh
	loader.RthreshProg = rustData.threshProgress
	loader.Rthreshmult = rustData.threshMult
	
	loader.SmushLevel = SmushLevel
	loader.Sxp = Sxp
	loader.Sxpthresh = Sxpthresh
	loader.Sxpthreshmult = Sxpthreshmult
	loader.Scurrent = Scurrent
	loader.StimeLeft = StimeLeft
	loader.SpendingRots = SpendingRots
	loader.Sspinbuff = Sspinbuff
	loader.Sascbuff = Sascbuff
	loader.RitCandlesLit = RitCandlesLit
	loader.RitAscBuff = RitAscBuff
	loader.RitRotBuff = RitRotBuff
	loader.Aspinbuff = Aspinbuff
	loader.curEmotionBuff = curEmotionBuff
	loader.sigilCostSpin = sigilCostSpin
	loader.sigilCostRot = sigilCostRot
	loader.sigilCostSpinScale = sigilCostSpinScale
	loader.sigilCostRotScale = sigilCostRotScale
	loader.numberOfSigils = numberOfSigils
	loader.curSigilBuff = curSigilBuff
	loader.ifhell = ifhell
	loader.ifheaven = ifheaven
	loader.iffirstboot = iffirstboot
	loader.iffirstvoid = iffirstvoid
	loader.iffirstpack = iffirstpack
	loader.save_stats(loader)
	
func resetR0Stats():
	spin = 0
	spinPerClick = 1
	size = 1
	sucPerTick = 5
	sucTresh = 15
	curSucSize = 0
	sizeRecord = 1
	density = 1
	sucPerTDens = 1
	densTresh = 2
	curSucDens = 0
	wheelphase = 1
	rotations = 0
	
	rustData.resetData()
	
	SmushLevel = 1
	Sxp = 0
	Sxpthresh = 100
	Sxpthreshmult = 1.5
	Scurrent = [0,0,0,0]
	StimeLeft = [0,0,0,0]
	SpendingRots = 0
	Sspinbuff = 1
	Sascbuff = 1
	RitCandlesLit = [false,false,false,false,false,false]
	RitAscBuff = 1
	RitRotBuff = 1
	sigilCostSpin = 300
	sigilCostRot = 10
	sigilCostSpinScale = 1.3
	sigilCostRotScale = 3
	numberOfSigils = [false,false,false,false,false,false,false,false,false,false]
	curSigilBuff = 0

func resetR1Stats():
	ifhell = false
	ifheaven = false
	curEmotionBuff = 0
	Aspinbuff = 1
	
func resetPermStats():
	iffirstboot = true
	iffirstvoid = true
	iffirstpack = true
	
func getScientific(val):
	if(val > 1000):
		return fmat.scientific(val,2)
	else :
		return snapped(val,0.01)
	
func _dialouge(lbl,charat,time):
	if(is_instance_valid(lbl)):
		chars = charat
		if(chars <= lbl.text.length()):
			lbl.visible_characters = chars
			chars += 1
			await get_tree().create_timer(time).timeout
			_dialouge(lbl,chars,time)
		
func load_as_normal():
	loader = loader.load_stats()
	spin = loader.spin
	spinPerClick = loader.spinPerClick
	size = loader.size
	sucPerTick = loader.sucPerTick
	sucTresh = loader.sucTresh
	curSucSize = loader.curSucSize
	sizeRecord = loader.sizeRecord
	density = loader.density
	sucPerTDens = loader.sucPerTDens
	densTresh = loader.densTresh
	curSucDens = loader.curSucDens
	wheelphase = loader.wheelphase
	rotations = loader.rotations
	
	rustData = loader.rustData
#	rustData.rust = loader.rust
#	rustData.increaseSpin = loader.Rincreasespin
#	rustData.increaseSpinCost = loader.RincreasespinCost
#	rustData.increaseSpinScaling = loader.RincreasespinScaling
#	rustData.increaseHunger = loader.Rincreasehunger
#	rustData.increaseHungerCost = loader.RincreasehungerCost
#	rustData.increaseHungerScaling = loader.RincreasehungerScaling
#	rustData.increaseRust = loader.Rincreaserust
#	rustData.increaseRustCost = loader.RincreaserustCost
#	rustData.increaseRustScaling = loader.RincreaserustScaling
#	rustData.thresh = loader.Rthresh
#	rustData.perThresh = loader.Rperthresh
#	rustData.threshProg = loader.RthreshProg
#	rustData.threshMult = loader.Rthreshmult
	
	SmushLevel = loader.SmushLevel
	Sxp = loader.Sxp
	Sxpthresh = loader.Sxpthresh
	Sxpthreshmult = loader.Sxpthreshmult
	Scurrent = loader.Scurrent
	StimeLeft = loader.StimeLeft
	SpendingRots = loader.SpendingRots
	Sspinbuff = loader.Sspinbuff
	Sascbuff = loader.Sascbuff
	RitCandlesLit = loader.RitCandlesLit
	RitAscBuff = loader.RitAscBuff
	RitRotBuff = loader.RitRotBuff
	Aspinbuff = loader.Aspinbuff
	curEmotionBuff = loader.curEmotionBuff
	sigilCostRot = loader.sigilCostRot
	sigilCostSpin = loader.sigilCostSpin
	sigilCostRotScale = loader.sigilCostRotScale
	sigilCostSpinScale = loader.sigilCostSpinScale
	numberOfSigils = loader.numberOfSigils
	curSigilBuff = loader.curSigilBuff
	ifhell = loader.ifhell
	ifheaven = loader.ifheaven
	iffirstboot = loader.iffirstboot
	iffirstvoid = loader.iffirstvoid
	iffirstpack = loader.iffirstpack
