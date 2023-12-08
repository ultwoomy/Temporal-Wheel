extends Node
@export_group("R0stats")
@export var spin : float
@export var spinPerClick : float
@export var size : float
@export var sizeToggle : bool
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
@export var curEmotionBuff : int
@export var Aspinbuff : float
@export_group("R2stats")
@export var hellChallengeNerf : int
@export var ifhell : bool
@export var ifheaven : bool
@export_group("PermStats")
@export var iffirstboot : bool
@export var ifsecondboot : bool
@export var iffirstvoid : bool
@export var iffirstpack : bool
var chars = 0
var loader = preload("res://Resources/SaveData.tres")
var fmat = preload("res://Scripts/FormatNo.gd")
func _init():
	#create_data() # L.B: Needed for reset.
	#resetR0Stats()
	#resetR1Stats()
	#resetPermStats()
	#save_prog()
	load_as_normal()

func create_data():
	if (!rustData):
		rustData = RustData.new()
	if (!mushroomData):
		mushroomData = MushroomData.new()
	if (!ritualData):
		ritualData = RitualData.new()
	if (!sigilData):
		sigilData = SigilData.new()


func save_prog():
	loader.spin = spin
	loader.spinPerClick = spinPerClick
	loader.size = size
	loader.sizeToggle = sizeToggle
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
	loader.rustData = rustData
	loader.mushroomData = mushroomData
	loader.ritualData = ritualData
	loader.Aspinbuff = Aspinbuff
	loader.curEmotionBuff = curEmotionBuff
	loader.sigilData = sigilData
	loader.hellChallengeNerf = hellChallengeNerf
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
	sizeToggle = false
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
	mushroomData.resetData()
	ritualData.resetData()
	sigilData.resetData()


func resetR1Stats():
	curEmotionBuff = 0
	Aspinbuff = 1
	
func resetR2Stats():
	hellChallengeNerf = 0
	ifhell = false
	ifheaven = false
	
func resetPermStats():
	iffirstboot = true
	ifsecondboot = true
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
	mushroomData = loader.mushroomData
	ritualData = loader.ritualData
	Aspinbuff = loader.Aspinbuff
	curEmotionBuff = loader.curEmotionBuff
	sigilData = loader.sigilData
	hellChallengeNerf = loader.hellChallengeNerf
	ifhell = loader.ifhell
	ifheaven = loader.ifheaven
	iffirstboot = loader.iffirstboot
	ifsecondboot = loader.ifsecondboot
	iffirstvoid = loader.iffirstvoid
	iffirstpack = loader.iffirstpack
