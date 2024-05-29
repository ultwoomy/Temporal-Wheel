extends Resource
@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export var dollarData : DollarData
@export_group("R1stats")
@export var Aspinbuff : float
@export var curEmotionBuff : float
@export_group("R2stats")
@export var inContract : bool
@export var souls : float
@export var hellChallengeNerf : int
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
	curEmotionBuff = 0
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
	inContract = false
	hellChallengeNerf = -1
	hellChallengeLayer2 = -1
	hellChallengeInit = false
	ifhell = false
	ifheaven = false
	iffirstboot = true
	ifsecondboot = 0
	iffirstvoid = true
	iffirstpack = true
	iffirsthell = true
	iffirstatlas = true
	kbityProgSpin = 0
	kbityProgRot = 0
	altsigilsand = false
	altsigilcity = false
	altsigilnight = false
	altsigiltwins = false
	souls = 0
	musicvol = -6.0
	sfxvol = -6.0
	versNo = 11
	ratmail = 0

func save_stats(data):
	ResourceSaver.save(data,save_path)
	
