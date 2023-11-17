extends Node
@export_group("R0stats")
@export var spin : float
@export var spinPerClick : float
@export var size : float
@export var sucPerTick : float
@export var sucTresh : float
@export var curSucSize : float
@export var density : float
@export var sucPerTDens : float
@export var densTresh : float
@export var curSucDens : float
@export var wheelphase : int
@export var rotations : float
@export var rust : float
@export var Rincreasespin : float
@export var RincreasespinCost : float
@export var RincreasespinScaling : float
@export var Rincreasehunger : float
@export var RincreasehungerCost : float
@export var RincreasehungerScaling : float
@export var Rincreaserust : float
@export var RincreaserustCost : float
@export var RincreaserustScaling : float
@export var Rthresh : float
@export var Rperthresh : float
@export var RthreshProg : float
@export var Rthreshmult : float
@export var SmushLevel : float
@export var Sxp : float
@export var Sxpthresh : float
@export var Sxpthreshmult : float
@export var Scurrent : Array[int]
@export var StimeLeft : Array[float]
@export var SpendingRots : float
@export var Sspinbuff : float
@export var Sascbuff : float
@export var sigilCostSpin : float
@export var sigilCostRot : float
@export var sigilCostSpinScale : float
@export var sigilCostRotScale : float
@export var numberOfSigils : float
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
	loader.density = density
	loader.sucPerTDens = sucPerTDens
	loader.densTresh = densTresh
	loader.curSucDens = curSucDens
	loader.wheelphase = wheelphase
	loader.rotations = rotations
	loader.rust = rust
	loader.Rincreasespin = Rincreasespin
	loader.RincreasespinCost = RincreasespinCost
	loader.RincreasespinScaling = RincreasespinScaling
	loader.Rincreasehunger = Rincreasehunger
	loader.RincreasehungerCost = RincreasehungerCost
	loader.RincreasehungerScaling = RincreasehungerScaling
	loader.Rincreaserust = Rincreaserust
	loader.RincreaserustCost = RincreaserustCost
	loader.RincreaserustScaling = RincreaserustScaling
	loader.Rthresh = Rthresh
	loader.Rperthresh = Rperthresh
	loader.RthreshProg = RthreshProg
	loader.Rthreshmult = Rthreshmult
	loader.SmushLevel = SmushLevel
	loader.Sxp = Sxp
	loader.Sxpthresh = Sxpthresh
	loader.Sxpthreshmult = Sxpthreshmult
	loader.Scurrent = Scurrent
	loader.StimeLeft = StimeLeft
	loader.SpendingRots = SpendingRots
	loader.Sspinbuff = Sspinbuff
	loader.Sascbuff = Sascbuff
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
	sucPerTick = 1
	sucTresh = 10
	curSucSize = 0
	density = 1
	sucPerTDens = 1
	densTresh = 2
	curSucDens = 0
	wheelphase = 1
	rotations = 0
	rust = 0
	Rincreasespin = 1
	RincreasespinCost = 1
	RincreasespinScaling = 1.5
	Rincreasehunger = 1
	RincreasehungerCost = 1
	RincreasehungerScaling = 2
	Rincreaserust = 1
	RincreaserustCost = 2
	RincreaserustScaling = 3
	Rthresh = 1
	RthreshProg = 0
	Rperthresh = 1
	Rthreshmult = 1.5
	SmushLevel = 1
	Sxp = 0
	Sxpthresh = 100
	Sxpthreshmult = 1.5
	Scurrent = [0,0,0,0]
	StimeLeft = [0,0,0,0]
	SpendingRots = 0
	Sspinbuff = 1
	Sascbuff = 1
	sigilCostSpin = 300
	sigilCostRot = 10
	sigilCostSpinScale = 1.3
	sigilCostRotScale = 3
	numberOfSigils = 0
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
	chars = charat
	while(chars <= lbl.text.length()):
		lbl.visible_characters = chars
		chars += 1
		await get_tree().create_timer(time).timeout
		
func load_as_normal():
	loader = loader.load_stats()
	spin = loader.spin
	spinPerClick = loader.spinPerClick
	size = loader.size
	sucPerTick = loader.sucPerTick
	sucTresh = loader.sucTresh
	curSucSize = loader.curSucSize
	density = loader.density
	sucPerTDens = loader.sucPerTDens
	densTresh = loader.densTresh
	curSucDens = loader.curSucDens
	wheelphase = loader.wheelphase
	rotations = loader.rotations
	rust = loader.rust
	Rincreasespin = loader.Rincreasespin
	RincreasespinCost = loader.RincreasespinCost
	RincreasespinScaling = loader.RincreasespinScaling
	Rincreasehunger = loader.Rincreasehunger
	RincreasehungerCost = loader.RincreasehungerCost
	RincreasehungerScaling = loader.RincreasehungerScaling
	Rincreaserust = loader.Rincreaserust
	RincreaserustCost = loader.RincreaserustCost
	RincreaserustScaling = loader.RincreaserustScaling
	Rthresh = loader.Rthresh
	Rperthresh = loader.Rperthresh
	RthreshProg = loader.RthreshProg
	Rthreshmult = loader.Rthreshmult
	SmushLevel = loader.SmushLevel
	Sxp = loader.Sxp
	Sxpthresh = loader.Sxpthresh
	Sxpthreshmult = loader.Sxpthreshmult
	Scurrent = loader.Scurrent
	StimeLeft = loader.StimeLeft
	SpendingRots = loader.SpendingRots
	Sspinbuff = loader.Sspinbuff
	Sascbuff = loader.Sascbuff
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
