extends Node
# Global script.


#@ Constants
# Layer 1 Challenges
# This one does nothing. It is activated when the player 
const CHALLENGE_INCONGRUENT : ChallengeData = preload("res://Resources/Challenge/IncongruentChallenge.tres")
const CHALLENGE_BRAVE : ChallengeData = preload("res://Resources/Challenge/BraveChallenge.tres")
const CHALLENGE_SHARP : ChallengeData = preload("res://Resources/Challenge/SharpChallenge.tres")
const CHALLENGE_AWARE : ChallengeData = preload("res://Resources/Challenge/AwareChallenge.tres")
const CHALLENGE_CALM : ChallengeData = preload("res://Resources/Challenge/CalmChallenge.tres")
# Layer 2 Challenges
const CHALLENGE_SANDY : ChallengeData = preload("res://Resources/Challenge/SandyChallenge.tres")
const CHALLENGE_BITTERSWEET : ChallengeData = preload("res://Resources/Challenge/BittersweetChallenge.tres")
const CHALLENGE_STARVED : ChallengeData = preload("res://Resources/Challenge/StarvedChallenge.tres")
const CHALLENGE_FABULOUS : ChallengeData = preload("res://Resources/Challenge/FabulousChallenge.tres")


#@ Export Variables
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
@export var curEmotionBuff : int
@export var Aspinbuff : float
@export var ifhell : bool
@export var ifheaven : bool
@export var challenges : Array[ChallengeData] = [] :
	# L.B: This makes sure that there are NO duplicate challenge layers.
	# 	For better performance(?), just don't set challenges manually and use the function.
	set(value):
		for challenge in value:
			setChallenge(challenge)
#@export var hellChallengeNerf : int
@export var hellChallengeLayer2 : int
@export var hellChallengeInit : bool
@export var inContract : bool
@export var soulsData : SoulsData
@export var atlasData : AtlasData
@export var kbityData : KbityData
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


#@ Public Variables
var chars = 0
var loader = preload("res://Resources/SaveData.tres")
var fmat = preload("res://Scripts/FormatNo.gd")


#@ Virtual Methods
func _init():
	
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
	if not nightChallengeData:
		nightChallengeData = NightChallengeData.new()
	if not fearcatData:
		fearcatData = FearcatData.new()


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
	loader.nightChallengeData = nightChallengeData
	loader.fearcatData = fearcatData
	#loader.sigilData = sigilData
	loader.sand = sand
	loader.sandCost = sandCost
	loader.sandScaling = sandScaling
	
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
	loader.ifFirstZunda = ifFirstZunda
	loader.ifFirstFearcatDay = ifFirstFearcatDay
	loader.ifFirstFearcatNight = ifFirstFearcatNight
	# TODO: Add challenges variable to loader
	loader.challenges = challenges
#	loader.hellChallengeNerf = hellChallengeNerf
	loader.hellChallengeLayer2 = hellChallengeLayer2
	loader.hellChallengeInit = hellChallengeInit
	loader.altSigilSand = altSigilSand
	loader.altSigilCity = altSigilCity
	loader.altSigilNight = altSigilNight
	loader.altSigilTwins = altSigilTwins
	loader.inContract = inContract
	loader.currentSigilOrder = currentSigilOrder
	loader.nextSigilOrder = nextSigilOrder
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
	sand = 0
	sandCost = 5
	sandScaling = 3


func resetR1Stats():
	curEmotionBuff = -1
	Aspinbuff = 1
	ifhell = false
	if challenges.size() >= 1:
		challenges[0] = null  
#	hellChallengeNerf = -1


func resetR2Stats():
	ifheaven = false
	inContract = false
	if challenges.size() >= 2:
		challenges[1] = null
	hellChallengeInit = false
	soulsData.resetData()
	kbityData.resetData()
	atlasData.resetData()
	backpackData.resetData()
	Automation.clearAutomators()
	automatorVarsData.resetData()
	nightChallengeData.resetData()
	fearcatData.resetData()
	currentSigilOrder = SigilPurchaseOrder.new()
	nextSigilOrder = SigilPurchaseOrder.new()
	
func resetPermStats():
	ifFirstBoot = true
	ifSecondBoot = 0
	ifFirstVoid = true
	ifFirstPack = true
	ifFirstHell = true
	ifFirstAtlas = true
	ifFirstZunda = true
	ifFirstFearcatDay = true
	ifFirstFearcatNight = true
	altSigilSand = false
	altSigilCity = false
	altSigilNight = false
	altSigilTwins = false
	musicvol = -12.0
	sfxvol = -12.0
	versNo = 16
	ratmail = 0


func getScientific(val):
	if(val > 1000):
		return fmat.scientific(val,2)
	else :
		return snapped(val,0.01)


func setChallenge(challenge : ChallengeData) -> void:
	# If it's null, that just means there's no challenge in the slot
	if challenge == null:
		return
	# Check type
	if not challenge:
		printerr("ERROR: Unable to set challenge!")
		return
	
	# Make sure the array has a valid size to not be out of bounds.
	if challenges.size() <= challenge.layer:
		challenges.resize(challenge.layer + 1)
	
	# Set the challenge in the right layer.
	challenges[challenge.layer] = challenge


func hasChallenge(challenge : ChallengeData) -> bool:
	# Check to see if challenges is null.
	if not challenges:
		return false
	
	if challenge in challenges:
		return true
	else:
		return false


func doesLayerHaveChallenge(layer : ChallengeData.ChallengeLayer) -> bool:
	# Check to see if layer value is in bounds of the challenges array.
	if not challenges:
		return false
	if not (challenges.size() >= layer + 1):
		return false
	
	# If a ChallengeData is the element of the layer, then the layer has a challenge.
	if challenges[layer]:
		return true
	else:
		return false


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
		loader.altSigilNight = false
		versNo += 1
	if(versNo <= 12):
		loader.sand = 0
		loader.sandCost = 5
		loader.sandScaling = 3
		versNo += 1
	if(versNo <= 13):
		loader.nightChallengeData = NightChallengeData.new()
		loader.ifFirstZunda = true
		versNo += 1
	if(versNo <= 14):
		loader.fearcatData = FearcatData.new()
		var tempM = MushroomData.new()
		tempM.copy(loader.mushroomData, true)
		loader.mushroomData = tempM
		loader.ifFirstFearcatDay = true
		loader.ifFirstFearcatNight = true
		loader.currentSigilOrder = SigilPurchaseOrder.new()
		loader.nextSigilOrder = SigilPurchaseOrder.new()
		loader.dollarData = DollarData.new()
		versNo += 1
	if(versNo <= 15):
		loader.dollarData = DollarData.new()
		loader.nightChallengeData.initRequests()
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
	ifFirstBoot = loader.ifFirstBoot
	ifSecondBoot = loader.ifSecondBoot
	ifFirstVoid = loader.ifFirstVoid
	ifFirstPack = loader.ifFirstPack
	challenges = loader.challenges
#	hellChallengeNerf = loader.hellChallengeNerf
	ifFirstZunda = loader.ifFirstZunda
	inContract = loader.inContract
	musicvol = loader.musicvol
	sfxvol = loader.sfxvol
	ifFirstHell = loader.ifFirstHell
	soulsData = loader.soulsData
#	hellChallengeLayer2 = loader.hellChallengeLayer2
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
	nightChallengeData = loader.nightChallengeData
	fearcatData = loader.fearcatData
	currentSigilOrder = loader.currentSigilOrder
	nextSigilOrder = loader.nextSigilOrder
	sand = loader.sand
	sandCost = loader.sandCost
	sandScaling = loader.sandScaling


func unlock_all_sigils():
	const sigilPurchaseOrder : SigilPurchaseOrder = preload("res://Resources/Sigil Purchase Order/DefaultSigilPurchaseOrder.tres")
	for sigil in sigilPurchaseOrder.purchaseOrder:
		GVars.sigilData.acquiredSigils.append(sigil)
