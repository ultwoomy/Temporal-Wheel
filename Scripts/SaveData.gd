extends Resource
@export_group("R0stats")
@export var spinData : SpinData
@export var rustData : RustData
@export var mushroomData : MushroomData
@export var ritualData : RitualData
@export var sigilData : SigilData
@export_group("R1stats")
@export var Aspinbuff : float
@export var curEmotionBuff : float
@export_group("R2stats")
@export var inContract : bool
@export var souls : float
@export var hellChallengeNerf : int
@export var hellChallengeLayer2 : int
@export var ifhell : bool
@export var ifheaven : bool
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
var save_path = "user://stats.tres"
func load_stats():
	if ResourceLoader.exists(save_path):
		return load(save_path)
	return null
func _init():
	spinData = SpinData.new()
	rustData = RustData.new()
	mushroomData = MushroomData.new()
	ritualData = RitualData.new()
	Aspinbuff = 1
	curEmotionBuff = 0
	sigilData = SigilData.new()
	soulsData = SoulsData.new()
	inContract = false
	hellChallengeNerf = -1
	hellChallengeLayer2 = -1
	ifhell = false
	ifheaven = false
	iffirstboot = true
	ifsecondboot = 0
	iffirstvoid = true
	iffirstpack = true
	iffirsthell = true
	souls = 0
	musicvol = -6.0
	sfxvol = -6.0
	versNo = 0


func save_stats(data):
	ResourceSaver.save(data,save_path)
	
