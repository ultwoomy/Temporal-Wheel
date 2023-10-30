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
@export var Rincreasespin : int
@export var sigilCostSpin : float
@export var sigilCostRot : float
@export var sigilCostSpinScale : float
@export var sigilCostRotScale : float
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
	Rincreasespin = 0
	sigilCostSpin = 500
	sigilCostRot = 20
	sigilCostSpinScale = 1.2
	sigilCostRotScale = 3
	ifhell = false
	ifheaven = false
	iffirstboot = true
	iffirstvoid = true
	iffirstpack = true
func save_stats(data):
	ResourceSaver.save(data,save_path)
	
