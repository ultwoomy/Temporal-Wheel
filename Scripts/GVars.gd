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
@export var Rincreasespin : int
@export var sigilCostSpin : float
@export var sigilCostRot : float
@export var sigilCostSpinScale : float
@export var sigilCostRotScale : float
@export_group("R1stats")
@export var ifhell : bool
@export var ifheaven : bool
@export_group("PermStats")
@export var iffirstboot : bool
@export var iffirstvoid : bool
@export var iffirstpack : bool
var loader = preload("res://Resources/SaveData.tres")
func _init():
	resetR0Stats()
	resetR1Stats()
	resetPermStats()
	#load_as_normal()

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
	loader.sigilCostSpin = sigilCostSpin
	loader.sigilCostRot = sigilCostRot
	loader.sigilCostSpinScale = sigilCostSpinScale
	loader.sigilCostRotScale = sigilCostRotScale
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
	Rincreasespin = 0
	sigilCostSpin = 500
	sigilCostRot = 20
	sigilCostSpinScale = 1.2
	sigilCostRotScale = 3

func resetR1Stats():
	ifhell = false
	ifheaven = false
	
func resetPermStats():
	iffirstboot = true
	iffirstvoid = true
	iffirstpack = true
	
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
	sigilCostRot = loader.sigilCostRot
	sigilCostSpin = loader.sigilCostSpin
	sigilCostRotScale = loader.sigilCostRotScale
	sigilCostSpinScale = loader.sigilCostSpinScale
	ifhell = loader.ifhell
	ifheaven = loader.ifheaven
	iffirstboot = loader.iffirstbot
	iffirstvoid = loader.iffirstvoid
	iffirstpack = loader.iffirstpack
