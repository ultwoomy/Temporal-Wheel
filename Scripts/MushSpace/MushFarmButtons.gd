extends Node
class_name MushFarmButtons


#@ Signals
signal plantButtonPressed
signal harvestButtonPressed
signal removeButtonPressed


#@ Onready Variables
@onready var plant : Button = $PlantButton
@onready var harvest : Button = $HarvestButton
@onready var remove : Button = $DeleteButton


#@ Public Variables
var currentFrame : int
var rng : RandomNumberGenerator = RandomNumberGenerator.new()


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GVars.mushroomData.fearMushBuff = 1
	get_window().get_node("EventManager").mushroom_frame_changed.connect(_on_mushroom_frame_changed)
	#plant.pressed.connect(_plant)
	harvest.pressed.connect(_harvest)
	remove.pressed.connect(_remove)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func autoHarvest():
	var replantOrder = [-1,-1,-1,-1]
	for n in GVars.mushroomData.current.size():
		replantOrder[n] = GVars.mushroomData.current[n]
	_harvest()
	for n in GVars.mushroomData.current.size():
		if replantOrder[n] > 0:
			_plantSpecific(replantOrder[n],n)


#@ Private Methods
'
func _plant() -> void:
	var post10scaling = 1
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] == 0):
			GVars.mushroomData.current[n] = currentFrame + 1
			if(GVars.mushroomData.level > 10):
				post10scaling = GVars.mushroomData.level - 8
			if(GVars.curEmotionBuff == 3):
				GVars.mushroomData.timeLeft[n] = (currentFrame + 1) * 30 * post10scaling + GVars.mushroomData.level * 5 * post10scaling
			else:
				GVars.mushroomData.timeLeft[n] = (currentFrame + 1) * 15 * post10scaling + GVars.mushroomData.level * 10 * post10scaling
			get_window().get_node("EventManager").mushroom_planted.emit()
			break
'


func _plantSpecific(mushroomType, plotNo) -> void:
	var post10scaling = 1
	if(GVars.mushroomData.current[plotNo] == 0):
		GVars.mushroomData.current[plotNo] = mushroomType
		if(GVars.mushroomData.level > 10):
			post10scaling = GVars.mushroomData.level - 8
		if(GVars.curEmotionBuff == 3):
			GVars.mushroomData.timeLeft[plotNo] = mushroomType * 30 * post10scaling + GVars.mushroomData.level * 5 * post10scaling
		else:
			GVars.mushroomData.timeLeft[plotNo] = mushroomType * 15 * post10scaling + GVars.mushroomData.level * 10 * post10scaling
		get_window().get_node("EventManager").mushroom_planted.emit()


func _harvest() -> void:
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n] and (GVars.mushroomData.timeLeft[n] <= 0):
			_harvest_shroom(GVars.mushroomData.current[n])
			GVars.mushroomData.current[n] = 0
			GVars.mushroomData.timeLeft[n] = 0
			get_window().get_node("EventManager").mushroom_planted.emit()


func _harvest_shroom(val) -> void:
	var Ebuff = 1
	var EexpBuff = 1
	var soulsShroomBuff = 1
	if GVars.soulsData.doubleShroomChanceEnabled and rng.randf_range(0.0, 100.0) < GVars.soulsData.doubleShroomChance:
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


func _remove() -> void:
	for n in GVars.mushroomData.currentFarmPlots.size():
		if GVars.mushroomData.currentFarmPlots[n]:
			GVars.mushroomData.currentFarmPlots[n] = null
			GVars.mushroomData.timeLeft[n] = 0
	get_window().get_node("EventManager").mushroom_planted.emit()


# Should probably just use a signal for this one.
func _check_xp():
	while(GVars.mushroomData.xp >= GVars.mushroomData.xpThresh):
		GVars.mushroomData.level += 1
		GVars.mushroomData.xp -= GVars.mushroomData.xpThresh
		GVars.mushroomData.xpThresh *= GVars.mushroomData.xpThreshMult


func _on_mushroom_frame_changed(index) -> void:
	currentFrame = index
