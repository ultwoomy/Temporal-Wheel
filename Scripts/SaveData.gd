extends Resource
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

@export var mushroomData : MushroomData

@export var ritualData : RitualData

@export var sigilData : SigilData

@export_group("R1stats")
@export var ifhell : bool
@export var ifheaven : bool
@export var Aspinbuff : float
@export var curEmotionBuff : float
@export_group("PermStats")
@export var iffirstboot : bool
@export var iffirstvoid : bool
@export var iffirstpack : bool
var save_path = "user://stats.tres"
func load_stats():
	if ResourceLoader.exists(save_path):
		return load(save_path)
	return null
func _init():
	spin = 0
	spinPerClick = 1
	size = 1
	sucPerTick = 1
	sucTresh = 10
	curSucSize = 0
	sizeRecord = 1
	density = 1
	sucPerTDens = 1
	densTresh = 2
	curSucDens = 0
	wheelphase = 1
	rotations = 0
	
	rustData = RustData.new()
	
	mushroomData = MushroomData.new()
	
	ritualData = RitualData.new()
	
	Aspinbuff = 1
	curEmotionBuff = 0
	
	sigilData = SigilData.new()
	
	ifhell = false
	ifheaven = false
	iffirstboot = true
	iffirstvoid = true
	iffirstpack = true


func save_stats(data):
	ResourceSaver.save(data,save_path)
	
