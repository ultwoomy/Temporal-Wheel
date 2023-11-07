extends Resource
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
@export var sigilCostSpin : float
@export var sigilCostRot : float
@export var sigilCostSpinScale : float
@export var sigilCostRotScale : float
@export var numberOfSigils : float
@export var curSigilBuff : int
@export var ifhell : bool
@export var ifheaven : bool
@export var iffirstboot : bool
@export var iffirstvoid : bool
@export var iffirstpack : bool
var save_path = "user://stats.tres"
func load_stats():
	if ResourceLoader.exists(save_path):
		print("loaded")
		return load(save_path)
	print("loadednot")
	return null
func _init():
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
	Rthresh = 3
	Rperthresh = 1
	RthreshProg = 0
	Rthreshmult = 2
	sigilCostSpin = 500
	sigilCostRot = 20
	sigilCostSpinScale = 1.2
	sigilCostRotScale = 3
	numberOfSigils = 0
	curSigilBuff = 0
	ifhell = false
	ifheaven = false
	iffirstboot = true
	iffirstvoid = true
	iffirstpack = true
func save_stats(data):
	ResourceSaver.save(data,save_path)
	
