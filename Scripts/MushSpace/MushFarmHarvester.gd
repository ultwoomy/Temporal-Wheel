extends Node
class_name MushFarmHarvester


#@ Signals
signal mushroomsHarvested


#@ Constants
# (!) Name of shrooms should match resource name. Otherwise there will be an error.
const LAMP_SHROOM_NAME : String = "Lamp Shroom"
const ROT_SHROOM_NAME : String = "Rot Shroom"
const WINE_SHROOM_NAME : String = "Wine Shroom"
const TWIN_SHROOM_NAME : String = "Twin Shroom"
const FEAR_SHROOM_NAME : String = "Fear Shroom"


#@ Private Variables
var _rng : RandomNumberGenerator = RandomNumberGenerator.new()


#@ Public Methods
func harvest() -> void:
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n] and GVars.mushroomData.timeLeft[n] <= 0:
			_applyCropBuff(GVars.mushroomData.currentFarmPlots[n])
			GVars.mushroomData.currentFarmPlots[n] = null
			GVars.mushroomData.timeLeft[n] = 0
	mushroomsHarvested.emit()





#@ Private Methods
func _applyCropBuff(crop : MushroomCrop) -> void:
	var Ebuff = 1
	var EexpBuff = 1
	var soulsShroomBuff = 1
	
	if GVars.soulsData.doubleShroomChanceEnabled and _rng.randf_range(0.0, 100.0) < GVars.soulsData.doubleShroomChance:
		soulsShroomBuff = 2
	else:
		soulsShroomBuff = 1
	
	if GVars.hasChallengeActive(GVars.CHALLENGE_AWARE):
		Ebuff = 1/(log(GVars.spinData.rotations)/log(5) + 0.5)
	elif GVars.curEmotionBuff == 3:
		Ebuff = log(GVars.spinData.rotations)/log(5) + 0.5
		EexpBuff = GVars.rustData.fourth
	
	match crop.name:
		LAMP_SHROOM_NAME:  # Lamp Shroom: Gives momentum.
			GVars.spinData.momentum += GVars.spinData.momentumPerClick * GVars.mushroomData.level * GVars.spinData.size * GVars.spinData.density * GVars.rustData.increaseMomentum * GVars.mushroomData.momentumBuff * GVars.mushroomData.level * 20 * Ebuff * soulsShroomBuff
			GVars.mushroomData.xp += 25 * EexpBuff + GVars.fearcatData.fearcatBuffDay
		ROT_SHROOM_NAME:  # Rot Shroom: Gives rotations.
			GVars.spinData.rotations += (1 + GVars.mushroomData.level)/2 * (3 + Ebuff)/4 * 5 * soulsShroomBuff
			GVars.mushroomData.xp += 50 * EexpBuff + GVars.fearcatData.fearcatBuffDay
		WINE_SHROOM_NAME:  # Wine Shroom: Gives momentum buff.
			GVars.mushroomData.momentumBuff += (3 * (log(GVars.mushroomData.level + 1) * Ebuff/log(3)))/(pow(2,GVars.mushroomData.momentumBuff)) * soulsShroomBuff
			GVars.mushroomData.xp += 75 * EexpBuff + GVars.fearcatData.fearcatBuffDay
		TWIN_SHROOM_NAME:  # Twin Shroom: Gives an identity buff.
			GVars.mushroomData.ascBuff += (log(GVars.mushroomData.level + 1) * Ebuff/log(3))/(pow(1.5,GVars.mushroomData.ascBuff)) * soulsShroomBuff
			GVars.mushroomData.xp += 100 * EexpBuff + GVars.fearcatData.fearcatBuffDay
		FEAR_SHROOM_NAME:  # Fear Shroom: Gives grow speed.
			print(str((log(GVars.mushroomData.level + 1) * Ebuff/log(8))/(pow(1.5,GVars.mushroomData.fearMushBuff)) * soulsShroomBuff))
			GVars.mushroomData.fearMushBuff += (log(GVars.mushroomData.level + 1) * Ebuff/log(8))/(pow(1.5,GVars.mushroomData.fearMushBuff)) * soulsShroomBuff
			GVars.mushroomData.xp += 125 * EexpBuff * GVars.fearcatData.fearcatBuffDay
	
	_checkXp()


func _plantSpecific(crop : MushroomCrop, plotNumber : int) -> void:
	var post10scaling = 1
	if GVars.mushroomData.current[plotNumber] == 0:
		GVars.mushroomData.current[plotNumber] = crop
		if(GVars.mushroomData.level > 10):
			post10scaling = GVars.mushroomData.level - 8
		if(GVars.curEmotionBuff == 3):
			GVars.mushroomData.timeLeft[plotNumber] = (crop.baseHarvestTimeMultiplier * 30 + GVars.mushroomData.level * 5) * post10scaling
		else:
			GVars.mushroomData.timeLeft[plotNumber] = (crop.baseHarvestTimeMultiplier * 15 + GVars.mushroomData.level * 10) * post10scaling
		get_window().get_node("EventManager").mushroom_planted.emit()


# Should probably just use a signal for this one.
func _checkXp():
	while(GVars.mushroomData.xp >= GVars.mushroomData.xpThresh):
		GVars.mushroomData.level += 1
		GVars.mushroomData.xp -= GVars.mushroomData.xpThresh
		GVars.mushroomData.xpThresh *= GVars.mushroomData.xpThreshMult
