extends Node
class_name MushFarmHarvester


#@ Signals
signal mushroomsHarvested


#@ Private Variables
var _rng : RandomNumberGenerator = RandomNumberGenerator.new()


#@ Public Methods
func harvest() -> void:
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] != 0) and (GVars.mushroomData.timeLeft[n] <= 0):
			_harvest_shroom(GVars.mushroomData.current[n])
			GVars.mushroomData.current[n] = 0
			GVars.mushroomData.timeLeft[n] = 0
			get_window().get_node("EventManager").mushroom_planted.emit()


#@ Private Methods
func _harvest_shroom(val) -> void:
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
	
	if val == 1:
		GVars.spinData.spin += GVars.spinData.spinPerClick * GVars.mushroomData.level * GVars.spinData.size * GVars.spinData.density * GVars.rustData.increaseSpin * GVars.mushroomData.spinBuff * GVars.mushroomData.level * 20 * Ebuff * soulsShroomBuff
		GVars.mushroomData.xp += 25 * EexpBuff + GVars.fearcatData.fearcatBuffDay
	elif val == 2:
		GVars.spinData.rotations += (1 + GVars.mushroomData.level)/2 * (3 + Ebuff)/4 * 5 * soulsShroomBuff
		GVars.mushroomData.xp += 50 * EexpBuff + GVars.fearcatData.fearcatBuffDay
	elif val == 3:
		GVars.mushroomData.spinBuff += (3 * (log(GVars.mushroomData.level + 1) * Ebuff/log(3)))/(pow(2,GVars.mushroomData.spinBuff)) * soulsShroomBuff
		GVars.mushroomData.xp += 75 * EexpBuff + GVars.fearcatData.fearcatBuffDay
	elif val == 4:
		GVars.mushroomData.ascBuff += (log(GVars.mushroomData.level + 1) * Ebuff/log(3))/(pow(1.5,GVars.mushroomData.ascBuff)) * soulsShroomBuff
		GVars.mushroomData.xp += 100 * EexpBuff + GVars.fearcatData.fearcatBuffDay
	elif val == 5:
		print(str((log(GVars.mushroomData.level + 1) * Ebuff/log(8))/(pow(1.5,GVars.mushroomData.fearMushBuff)) * soulsShroomBuff))
		GVars.mushroomData.fearMushBuff += (log(GVars.mushroomData.level + 1) * Ebuff/log(8))/(pow(1.5,GVars.mushroomData.fearMushBuff)) * soulsShroomBuff
		GVars.mushroomData.xp += 125 * EexpBuff * GVars.fearcatData.fearcatBuffDay
	
	_check_xp()


# Should probably just use a signal for this one.
func _check_xp():
	while(GVars.mushroomData.xp >= GVars.mushroomData.xpThresh):
		GVars.mushroomData.level += 1
		GVars.mushroomData.xp -= GVars.mushroomData.xpThresh
		GVars.mushroomData.xpThresh *= GVars.mushroomData.xpThreshMult
