extends Node
@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export_group("R1stats")
@export var curEmotionBuff : int
@export var Aspinbuff : float
@export var ifhell : bool
@export var ifheaven : bool
@export var hellChallengeNerf : int
@export var inContract : bool
@export_group("PermStats")
@export var iffirstboot : bool
@export var ifsecondboot : int
@export var iffirstvoid : bool
@export var iffirstpack : bool
@export var musicvol : float
@export var sfxvol : float
var chars = 0
var loader = preload("res://Resources/SaveData.tres")
var fmat = preload("res://Scripts/FormatNo.gd")


func _init():
#	create_data() # L.B: Needed for reset.
#	resetR0Stats()
#	resetR1Stats()
#	resetPermStats()
#	save_prog()
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
	if (!spinData):
		spinData = SpinData.new()


func save_prog():
	loader.spinData = spinData
	
	loader.rustData = rustData
	
	loader.mushroomData = mushroomData
	
	loader.ritualData = ritualData
	
	loader.Aspinbuff = Aspinbuff
	loader.curEmotionBuff = curEmotionBuff
	
	loader.sigilData = sigilData
	
	loader.ifhell = ifhell
	loader.ifheaven = ifheaven
	loader.iffirstboot = iffirstboot
	loader.ifsecondboot = ifsecondboot
	loader.iffirstvoid = iffirstvoid
	loader.iffirstpack = iffirstpack
	loader.hellChallengeNerf = hellChallengeNerf
	loader.inContract = inContract
	loader.musicvol = musicvol
	loader.sfxvol = sfxvol
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
	ifhell = false
	ifheaven = false
	hellChallengeNerf = -1
	inContract = false


func resetPermStats():
	iffirstboot = true
	ifsecondboot = 0
	iffirstvoid = true
	iffirstpack = true
	musicvol = -6.0
	sfxvol = -6.0


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
	ifhell = loader.ifhell
	ifheaven = loader.ifheaven
	iffirstboot = loader.iffirstboot
	ifsecondboot = loader.ifsecondboot
	iffirstvoid = loader.iffirstvoid
	iffirstpack = loader.iffirstpack
	hellChallengeNerf = loader.hellChallengeNerf
	inContract = loader.inContract
	musicvol = loader.musicvol
	sfxvol = loader.sfxvol

func unlock_all_sigils():
	for n in GVars.sigilData.numberOfSigils.size():
		GVars.sigilData.numberOfSigils[n] = true
