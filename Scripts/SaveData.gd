extends Resource
# Note: ResourceSaver only saves exported variables, probably because Resources use exported variables
#	when creating a resource.


@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export var dollarData : DollarData
@export var sand : float
@export var sandCost : float
@export var sandScaling : float
@export_group("R1stats")
@export var Aspinbuff : float
@export var curEmotionBuff : float
@export_group("R2stats")
@export var inContract : bool
@export var souls : float
@export var challenges : Array[ChallengeData]
#@export var hellChallengeNerf : int
@export var hellChallengeLayer2 : int
@export var hellChallengeInit : bool
@export var kbityProgSpin : float
@export var kbityProgRot : float
@export var ifhell : bool
@export var ifheaven : bool
@export var soulsData : SoulsData
@export var kbityData : KbityData
@export var atlasData : AtlasData
@export var backpackData : BackpackData
@export var automatorVarsData : AutomatorVarsData
@export var nightChallengeData : NightChallengeData
@export var fearcatData : FearcatData
@export var currentSigilOrder : SigilPurchaseOrder
@export var nextSigilOrder : SigilPurchaseOrder
@export_group("PermStats")
@export var ifFirstBoot : bool
@export var ifSecondBoot : int
@export var ifFirstVoid : bool
@export var ifFirstPack : bool
@export var ifFirstHell : bool
@export var ifFirstAtlas : bool
@export var ifFirstZunda : bool
@export var ifFirstFearcatDay : bool
@export var ifFirstFearcatNight : bool
@export var altSigilSand : bool
@export var altSigilCity : bool
@export var altSigilNight : bool
@export var altSigilTwins : bool
@export var musicvol : float
@export var sfxvol : float
@export var versNo : int
@export var ratmail : int
var save_path = "user://stats.tres"


func load_stats():
	if ResourceLoader.exists(save_path):
		return load(save_path)
	else:
		_init()
		save_stats(self)
	return load(save_path)


func _init():
	spinData = SpinData.new()
	spinData.resetData()
	rustData = RustData.new()
	rustData.resetData()
	mushroomData = MushroomData.new()
	mushroomData.resetData()
	ritualData = RitualData.new()
	ritualData.resetData()
	Aspinbuff = 1
	curEmotionBuff = -1
	sigilData = SigilData.new()
	sigilData.resetData()
	soulsData = SoulsData.new()
	soulsData.resetData()
	dollarData = DollarData.new()
	dollarData.resetData()
	atlasData = AtlasData.new()
	atlasData.resetData()
	kbityData = KbityData.new()
	kbityData.resetData()
	backpackData = BackpackData.new()
	automatorVarsData = AutomatorVarsData.new()
	nightChallengeData = NightChallengeData.new()
	fearcatData = FearcatData.new()
	currentSigilOrder = SigilPurchaseOrder.new()
	nextSigilOrder = SigilPurchaseOrder.new()
	sand = 0
	sandCost = 7
	sandScaling = 3
	inContract = false
	challenges = []
#	hellChallengeNerf = -1
	hellChallengeLayer2 = -1
	hellChallengeInit = false
	ifhell = false
	ifheaven = false
	ifFirstBoot = true
	ifSecondBoot = 0
	ifFirstVoid = true
	ifFirstPack = true
	ifFirstHell = true
	ifFirstAtlas = true
	ifFirstZunda = true
	ifFirstFearcatDay = true
	ifFirstFearcatNight = true
	kbityProgSpin = 0
	kbityProgRot = 0
	altSigilSand = false
	altSigilCity = false
	altSigilNight = false
	altSigilTwins = false
	souls = 0
	musicvol = -6.0
	sfxvol = -6.0
	versNo = 16
	ratmail = 0

func save_stats(data):
	if ResourceSaver.save(data, save_path):
		printerr("ERROR: Failed to save!")
