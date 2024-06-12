extends Node


@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export var dollarData : DollarData
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
@export var atlasData : AtlasData
@export var kbityData : KbityData
@export var backpackData : BackpackData
@export_group("PermStats")
@export var iffirstboot : bool
@export var ifsecondboot : int
@export var iffirstvoid : bool
@export var iffirstpack : bool
@export var iffirsthell : bool
@export var iffirstatlas : bool
@export var altsigilsand : bool
@export var altsigilcity : bool
@export var altsigilnight : bool
@export var altsigiltwins : bool
@export var musicvol : float
@export var sfxvol : float
@export var versNo : int
@export var ratmail : int
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
	if not rustData:
		rustData = RustData.new()
	if not mushroomData:
		mushroomData = MushroomData.new()
	if not ritualData:
		ritualData = RitualData.new()
	if not sigilData:
		sigilData = SigilData.new()
	if not spinData:
		spinData = SpinData.new()
	if(!soulsData):
		soulsData = SoulsData.new()
	if(!dollarData):
		dollarData = DollarData.new()
	if(!atlasData):
		atlasData = AtlasData.new()
	if(!kbityData):
		kbityData = KbityData.new()
	if(!backpackData):
		backpackData = BackpackData.new()


func save_prog():
	loader.spinData = spinData
	loader.rustData = rustData
	loader.mushroomData = mushroomData
	loader.ritualData = ritualData
	loader.Aspinbuff = Aspinbuff
	loader.curEmotionBuff = curEmotionBuff
	loader.sigilData = sigilData
	loader.soulsData = soulsData
	loader.dollarData = dollarData
	loader.atlasData = atlasData
	loader.kbityData = kbityData
	loader.backpackData = backpackData
	#loader.sigilData = sigilData
	
	#loader.Aspinbuff = Aspinbuff
	#loader.curEmotionBuff = curEmotionBuff
	
	loader.ifhell = ifhell
	loader.ifheaven = ifheaven
	loader.iffirstboot = iffirstboot
	loader.ifsecondboot = ifsecondboot
	loader.iffirstvoid = iffirstvoid
	loader.iffirstpack = iffirstpack
	loader.iffirsthell = iffirsthell
	loader.iffirstatlas = iffirstatlas
	loader.hellChallengeNerf = hellChallengeNerf
	loader.hellChallengeLayer2 = hellChallengeLayer2
	loader.hellChallengeInit = hellChallengeInit
	loader.altsigilsand = altsigilsand
	loader.altsigilcity = altsigilcity
	loader.altsigilnight = altsigilnight
	loader.altsigiltwins = altsigiltwins
	loader.inContract = inContract
	loader.musicvol = musicvol
	loader.sfxvol = sfxvol
	loader.versNo = versNo
	loader.ratmail = ratmail
	loader.save_stats(loader)


func resetR0Stats():
	spinData.resetData()
	rustData.resetData()
	mushroomData.resetData()
	ritualData.resetData()
	sigilData.resetData()
	dollarData.resetData()

func resetR1Stats():
	curEmotionBuff = -1
	Aspinbuff = 1
	ifhell = false
	hellChallengeNerf = -1
	
func resetR2Stats():
	ifheaven = false
	inContract = false
	hellChallengeLayer2 = -1
	hellChallengeInit = false
	soulsData.resetData()
	kbityData.resetData()
	atlasData.resetData()
	backpackData.resetData()
	
func resetPermStats():
	iffirstboot = true
	ifsecondboot = 0
	iffirstvoid = true
	iffirstpack = true
	iffirsthell = true
	iffirstatlas = true
	altsigilsand = false
	altsigilcity = false
	altsigilnight = false
	altsigiltwins = false
	musicvol = -12.0
	sfxvol = -12.0
	versNo = 11
	ratmail = 0
	
func getScientific(val):
	if(val > 1000):
		return fmat.scientific(val,2)
	else :
		return snapped(val,0.01)


# TODO: Move this function elsewhere. Maybe DialogueHandler.gd?
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
	versNo = loader.versNo
	if(versNo <= 8):
		create_data() # L.B: Needed for reset.
		resetR0Stats()
		resetR1Stats()
		resetPermStats()
		save_prog()
		return
	if(versNo <= 9):
		loader.atlasData.resetData()
		versNo += 1
	if(versNo <= 10):
		backpackData = BackpackData.new()
		loader.backpackData = backpackData
		if loader.ifsecondboot >= 2:
			loader.ifsecondboot = 2
			loader.ratmail = 0
		versNo += 1
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
	iffirsthell = loader.iffirsthell
	soulsData = loader.soulsData
	hellChallengeLayer2 = loader.hellChallengeLayer2
	hellChallengeInit = loader.hellChallengeInit
	ratmail = loader.ratmail
	dollarData = loader.dollarData
	iffirstatlas = loader.iffirstatlas
	altsigilsand = loader.altsigilsand
	altsigilcity = loader.altsigilcity
	altsigilnight = loader.altsigilnight
	altsigiltwins = loader.altsigiltwins
	kbityData = loader.kbityData
	atlasData = loader.atlasData
	backpackData = loader.backpackData


func unlock_all_sigils():
	for n in GVars.sigilData.numberOfSigils.size():
		GVars.sigilData.numberOfSigils[n] = true
