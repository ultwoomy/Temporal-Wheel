extends Node
# Global script.


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
@export var automatorVarsData : AutomatorVarsData
@export_group("PermStats")
@export var ifFirstBoot : bool
@export var ifSecondBoot : int
@export var ifFirstVoid : bool
@export var ifFirstPack : bool
@export var ifFirstHell : bool
@export var ifFirstAtlas : bool
@export var altSigilSand : bool
@export var altSigilCity : bool
@export var altSigilNight : bool
@export var altSigilTwins : bool
@export var musicvol : float
@export var sfxvol : float
@export var versNo : int
@export var ratmail : int


#@ Public Variables
var chars = 0
var loader = preload("res://Resources/SaveData.tres")
var fmat = preload("res://Scripts/FormatNo.gd")


#@ Virtual Methods
func _init():
	#create_data() # L.B: Needed for reset.
	#resetR0Stats()
	#resetR1Stats()
	#resetPermStats()
	#save_prog()
	load_as_normal()


#@ Public Methods
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
	if not automatorVarsData:
		automatorVarsData = AutomatorVarsData.new()


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
	loader.ifFirstBoot = ifFirstBoot
	loader.ifSecondBoot = ifSecondBoot
	loader.ifFirstVoid = ifFirstVoid
	loader.ifFirstPack = ifFirstPack
	loader.ifFirstHell = ifFirstHell
	loader.ifFirstAtlas = ifFirstAtlas
	loader.hellChallengeNerf = hellChallengeNerf
	loader.hellChallengeLayer2 = hellChallengeLayer2
	loader.hellChallengeInit = hellChallengeInit
	loader.altSigilSand = altSigilSand
	loader.altSigilCity = altSigilCity
	loader.altSigilNight = altSigilNight
	loader.altSigilTwins = altSigilTwins
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
	ifFirstBoot = true
	ifSecondBoot = 0
	ifFirstVoid = true
	ifFirstPack = true
	ifFirstHell = true
	ifFirstAtlas = true
	altSigilSand = false
	altSigilCity = false
	altSigilNight = false
	altSigilTwins = false
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
		if loader.ifSecondBoot >= 2:
			loader.ifSecondBoot = 2
			loader.ratmail = 0
		versNo += 1
	if(versNo <= 11):
		automatorVarsData = AutomatorVarsData.new()
		loader.automatorVarsData = automatorVarsData
		loader.altsigilnight = false
	spinData = loader.spinData
	rustData = loader.rustData
	mushroomData = loader.mushroomData
	ritualData = loader.ritualData
	Aspinbuff = loader.Aspinbuff
	curEmotionBuff = loader.curEmotionBuff
	sigilData = loader.sigilData
	ifhell = loader.ifhell
	ifheaven = loader.ifheaven
	ifFirstBoot = loader.ifFirstBoot
	ifSecondBoot = loader.ifSecondBoot
	ifFirstVoid = loader.ifFirstVoid
	ifFirstPack = loader.ifFirstPack
	hellChallengeNerf = loader.hellChallengeNerf
	inContract = loader.inContract
	musicvol = loader.musicvol
	sfxvol = loader.sfxvol
	ifFirstHell = loader.ifFirstHell
	soulsData = loader.soulsData
	hellChallengeLayer2 = loader.hellChallengeLayer2
	hellChallengeInit = loader.hellChallengeInit
	ratmail = loader.ratmail
	dollarData = loader.dollarData
	ifFirstAtlas = loader.ifFirstAtlas
	altSigilSand = loader.altSigilSand
	altSigilCity = loader.altSigilCity
	altSigilNight = loader.altSigilNight
	altSigilTwins = loader.altSigilTwins
	kbityData = loader.kbityData
	atlasData = loader.atlasData
	backpackData = loader.backpackData
	automatorVarsData = loader.automatorVarsData


func unlock_all_sigils():
	for n in GVars.sigilData.numberOfSigils.size():
		GVars.sigilData.numberOfSigils[n] = true
