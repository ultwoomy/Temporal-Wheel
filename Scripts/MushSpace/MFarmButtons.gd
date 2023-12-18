extends Node

## Components
@export var plant : Button
@export var harvest : Button
@export var remove : Button


## Functions
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plant.pressed.connect(_plant)
	harvest.pressed.connect(_harvest)
	remove.pressed.connect(_remove)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _plant():
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] == 0):
			GVars.mushroomData.current[n] = curFrame + 1
			if(GVars.sigilData.curSigilBuff == 2):
				GVars.mushroomData.timeLeft[n] = (curFrame + 1) * 10 + GVars.mushroomData.level * 8
			else:
				GVars.mushroomData.timeLeft[n] = (curFrame + 1) * 15 + GVars.mushroomData.level * 10
			_update_sprites()
			return


func _harvest():
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] != 0) and (GVars.mushroomData.timeLeft[n] <= 0):
			_harvest_shroom(GVars.mushroomData.current[n])
			GVars.mushroomData.current[n] = 0
			GVars.mushroomData.timeLeft[n] = 0
			_update_sprites()


func _harvest_shroom(val):
	var Ebuff = 1
	var EexpBuff = 1
	if(GVars.curEmotionBuff == 3):
		Ebuff = (log(GVars.rotations))/2 + 0.5
		EexpBuff = GVars.rustData.fourth
	if(val == 1):
		GVars.spin += GVars.spinPerClick * GVars.size * GVars.density * GVars.rustData.increaseSpin * GVars.mushroomData.spinBuff * GVars.mushroomData.level * 20 * Ebuff
		GVars.mushroomData.xp += 25 * EexpBuff
	elif(val == 2):
		GVars.rotations += GVars.mushroomData.level * 3 * Ebuff
		GVars.mushroomData.xp += 50 * EexpBuff
	elif(val == 3):
		GVars.mushroomData.spinBuff += (3 * (log(GVars.mushroomData.level + 1) * Ebuff/log(3)))/(pow(2,GVars.mushroomData.spinBuff))
		GVars.mushroomData.xp += 75 * EexpBuff
	elif(val == 4):
		GVars.mushroomData.ascBuff += (log(GVars.mushroomData.level + 1) * Ebuff/log(3))/(2 * GVars.mushroomData.ascBuff)
		GVars.mushroomData.xp += 100 * EexpBuff
	_check_xp()


func _remove():
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] != 0):
			GVars.mushroomData.current[n] = 0
			GVars.mushroomData.timeLeft[n] = 0
