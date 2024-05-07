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
@export var hellChallengeLayer2 : int
@export var hellChallengeInit : bool
@export var inContract : bool
@export var soulsData : SoulsData
@export_group("PermStats")
@export var iffirstboot : bool
@export var ifsecondboot : int
@export var iffirstvoid : bool
@export var iffirstpack : bool
@export var iffirsthell : bool
@export var musicvol : float
@export var sfxvol : float
@export var versNo : int
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
	if(!soulsData):
		soulsData = SoulsData.new()


func save_prog():
	loader.spinData = spinData
	
	loader.rustData = rustData
	
	loader.mushroomData = mushroomData
	
	loader.ritualData = ritualData
	
	loader.Aspinbuff = Aspinbuff
	loader.curEmotionBuff = curEmotionBuff
	
	loader.sigilData = sigilData
	
	loader.soulsData = soulsData
	
	loader.ifhell = ifhell
	loader.ifheaven = ifheaven
	loader.iffirstboot = iffirstboot
	loader.ifsecondboot = ifsecondboot
	loader.iffirstvoid = iffirstvoid
	loader.iffirstpack = iffirstpack
	loader.iffirsthell = iffirsthell
	loader.hellChallengeNerf = hellChallengeNerf
	loader.hellChallengeLayer2 = hellChallengeLayer2
	loader.hellChallengeInit = hellChallengeInit
	loader.inContract = inContract
	loader.musicvol = musicvol
	loader.sfxvol = sfxvol
	loader.versNo = versNo
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
	ifhell = false
	hellChallengeNerf = -1
	
func resetR2Stats():
	ifheaven = false
	inContract = false
	hellChallengeLayer2 = -1
	hellChallengeInit = false
	soulsData.resetData()
	
func resetPermStats():
	iffirstboot = true
	ifsecondboot = 0
	iffirstvoid = true
	iffirstpack = true
	iffirsthell = true
	musicvol = -12.0
	sfxvol = -12.0
	versNo = 2
	
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
	if(loader.versNo == 0):
		iffirsthell = true
		versNo = loader.versNo + 1
		soulsData = SoulsData.new()
		soulsData.resetData()
		hellChallengeLayer2 = -1
	if(loader.versNo <= 1):
		soulsData = SoulsData.new()
		soulsData.resetData()
		versNo = loader.versNo + 1
	if(loader.versNo <= 2):
		hellChallengeInit = false
		versNo = loader.versNo + 1
	else:
		iffirsthell = loader.iffirsthell
		versNo = loader.versNo
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
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
