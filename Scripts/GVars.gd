extends Node
@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export_group("R1stats")
@export var spinBotStats : Spinbot
@export var curEmotionBuff : int
@export var Aspinbuff : float
@export_group("R2stats")
@export var hellChallengeNerf : int
@export var inContract : bool
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

func unlock_all_sigils():
	for n in sigilData.numberOfSigils.size():
		sigilData.numberOfSigils[n] = true

func create_data():
	if(!spinData):
		spinData = SpinData.new()
	if (!rustData):
		rustData = RustData.new()
	if (!mushroomData):
		mushroomData = MushroomData.new()
	if (!ritualData):
		ritualData = RitualData.new()
	if (!sigilData):
		sigilData = SigilData.new()


func save_prog():
	loader.spinData = spinData
	loader.rustData = rustData
	loader.mushroomData = mushroomData
	loader.ritualData = ritualData
	loader.Aspinbuff = Aspinbuff
	loader.curEmotionBuff = curEmotionBuff
	loader.sigilData = sigilData
	loader.inContract = inContract
	loader.hellChallengeNerf = hellChallengeNerf
	loader.ifhell = ifhell
	loader.ifheaven = ifheaven
	loader.iffirstboot = iffirstboot
	loader.iffirstvoid = iffirstvoid
	loader.iffirstpack = iffirstpack
	loader.save_stats(loader)
	
func resetR0Stats():
	spinData.resetData()
	rustData.resetData()
	mushroomData.resetData()
	ritualData.resetData()
	sigilData.resetData()

func resetR1Stats():
	curEmotionBuff = 0
	Aspinbuff = 1
	
func resetR2Stats():
	inContract = false
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
	spinData = loader.spinData
	rustData = loader.rustData
	mushroomData = loader.mushroomData
	ritualData = loader.ritualData
	Aspinbuff = loader.Aspinbuff
	curEmotionBuff = loader.curEmotionBuff
	sigilData = loader.sigilData
	inContract = loader.inContract
	hellChallengeNerf = loader.hellChallengeNerf
	ifhell = loader.ifhell
	ifheaven = loader.ifheaven
	iffirstboot = loader.iffirstboot
	ifsecondboot = loader.ifsecondboot
	iffirstvoid = loader.iffirstvoid
	iffirstpack = loader.iffirstpack
