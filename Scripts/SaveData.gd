extends Resource
# Note: ResourceSaver only saves exported variables, probably because Resources use exported variables
#	when creating a resource.


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
@export var hellChallengeNerf : int
@export var ifhell : bool
@export var ifheaven : bool
@export_group("PermStats")
@export var iffirstboot : bool
@export var ifsecondboot : int
@export var iffirstvoid : bool
@export var iffirstpack : bool
@export var musicvol : float
@export var sfxvol : float
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
	inContract = false
	hellChallengeNerf = -1
	ifhell = false
	ifheaven = false
	iffirstboot = true
	ifsecondboot = 0
	iffirstvoid = true
	iffirstpack = true
	musicvol = -6.0
	sfxvol = -6.0


func save_stats(data):
	if ResourceSaver.save(data, save_path):
		printerr("ERROR: Failed to save!")
