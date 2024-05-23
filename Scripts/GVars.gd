extends Node
@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export var dollarData : DollarData
@export var atlasData : AtlasData
@export var kbityData : KbityData
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
	if(!dollarData):
		dollarData = DollarData.new()
	if(!atlasData):
		atlasData = AtlasData.new()
	if(!kbityData):
		kbityData = KbityData.new()


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
	kbityData.resetData()
	atlasData.resetData()
	
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
	versNo = 9
	ratmail = 0
	
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
	versNo = loader.versNo
	if(versNo == 0):
		iffirsthell = true
		versNo = versNo + 1
		soulsData = SoulsData.new()
		soulsData.resetData()
		hellChallengeLayer2 = -1
	if(versNo <= 1):
		soulsData = SoulsData.new()
		soulsData.resetData()
		iffirsthell = loader.iffirsthell
		hellChallengeLayer2 = loader.hellChallengeLayer2
		versNo = versNo + 1
	if(versNo <= 2):
		hellChallengeInit = false
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		versNo = versNo + 1
	if(versNo <= 3):
		ratmail = 0
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
		versNo = versNo + 1
	if(versNo <= 4):
		dollarData = DollarData.new()
		dollarData.resetData()
		versNo = versNo + 1
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
		ratmail = loader.ratmail
	if(versNo <= 5):
		iffirstatlas = true
		atlasData = AtlasData.new()
		atlasData.resetData()
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
		ratmail = loader.ratmail
		dollarData = loader.dollarData
		versNo = versNo + 1
	if(versNo <= 6):
		altsigilsand = false
		altsigilcity = false
		altsigilnight = false
		altsigiltwins = false
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
		ratmail = loader.ratmail
		dollarData = loader.dollarData
		iffirstatlas = loader.iffirstatlas
		atlasData = loader.atlasData
		versNo = versNo + 1
	if(versNo <= 7):
		kbityData = KbityData.new()
		kbityData.resetData()
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
		ratmail = loader.ratmail
		dollarData = loader.dollarData
		iffirstatlas = loader.iffirstatlas
		atlasData = loader.atlasData
		altsigilsand = loader.altsigilsand
		altsigilcity = loader.altsigilcity
		altsigilnight = loader.altsigilnight
		altsigiltwins = loader.altsigiltwins
		versNo = versNo + 1
	if(versNo <= 8):
		atlasData = AtlasData.new()
		atlasData.resetData()
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
		versNo = versNo + 1
	else:
		iffirsthell = loader.iffirsthell
		soulsData = loader.soulsData
		hellChallengeLayer2 = loader.hellChallengeLayer2
		hellChallengeInit = loader.hellChallengeInit
		ratmail = loader.ratmail
		dollarData = loader.dollarData
		iffirstatlas = loader.iffirstatlas
		atlasData = loader.atlasData
		altsigilsand = loader.altsigilsand
		altsigilcity = loader.altsigilcity
		altsigilnight = loader.altsigilnight
		altsigiltwins = loader.altsigiltwins
		kbityData = loader.kbityData
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
