extends Node
@export var left : Button
@export var right : Button
@export var plant : Button
@export var plot1 : AnimatedSprite2D
@export var plot2 : AnimatedSprite2D
@export var plot3 : AnimatedSprite2D
@export var plot4 : AnimatedSprite2D
@export var disp1 : Label
@export var disp2 : Label
@export var disp3 : Label
@export var disp4 : Label
@export var harvest : Button
@export var currentMush : AnimatedSprite2D
@export var desc : Label
@export var xpbar : Sprite2D
@export var leveldisp : Label
@export var statsdisp : Label
@export var curFrame : int
# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.mushroomData.pendingRots < 0):
		GVars.mushroomData.pendingRots = 0
	for n in GVars.mushroomData.current.size():
		GVars.mushroomData.timeLeft[n] -= GVars.mushroomData.pendingRots
		if(GVars.mushroomData.timeLeft[n] <= 0):
			GVars.mushroomData.timeLeft[n] = 0
	_update_sprites()
	GVars.mushroomData.pendingRots = 0
	desc.size = Vector2(216,90)
	desc.position = Vector2(90,350)
	currentMush.frame = 0
	curFrame = 0
	_setdesc()
	left.pressed.connect(self._left)
	right.pressed.connect(self._right)
	plant.pressed.connect(self._plant)
	harvest.pressed.connect(self._harvest)

func _left():
	if(curFrame == 0):
		curFrame = 3
	else:
		curFrame -= 1
	_setdesc()
	currentMush.frame = curFrame
	
func _right():
	if(curFrame == 3):
		curFrame = 0
	else:
		curFrame += 1
	_setdesc()
	currentMush.frame = curFrame
	
func _setdesc():
	if(curFrame == 0):
		desc.text = "Lamp Shroom\nLights up your day.\nGives you momentum."
	elif(curFrame == 1):
		desc.text = "Rot Shroom\nThey are tight knit friends.\nGives you rotations."
	elif(curFrame == 2):
		desc.text = "Wine Shroom\nA lot of fun at parties.\nGives you a momentum bonus."
	elif(curFrame == 3):
		desc.text = "Twin Shroom\nWhispers to you.\nGives you a identity bonus."
	else:
		desc.text = ""

func _plant():
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] == 0):
			GVars.mushroomData.current[n] = curFrame + 1
			if(GVars.curSigilBuff == 2):
				GVars.mushroomData.timeLeft[n] = (curFrame + 1) * 10 + GVars.mushroomData.level * 8
			else:
				GVars.mushroomData.timeLeft[n] = (curFrame + 1) * 15 + GVars.mushroomData.level * 10
			_update_sprites()
			return
			
func _update_sprites():
	plot1.hide()
	plot2.hide()
	plot3.hide()
	plot4.hide()
	disp1.hide()
	disp2.hide()
	disp3.hide()
	disp4.hide()
	xpbar.scale.x = GVars.mushroomData.xp/GVars.mushroomData.xpThresh*1.5
	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.mushroomData.level))
	statsdisp.text = "Buffs\nSpin Buff: " + str(GVars.getScientific(GVars.mushroomData.spinBuff)) + "\nIdentity Buff: " + str(GVars.getScientific(GVars.mushroomData.ascBuff))
	for n in GVars.mushroomData.current.size():
		if(GVars.mushroomData.current[n] != 0):
			if(n == 0):
				plot1.show()
				plot1.frame = GVars.mushroomData.current[n] - 1
				plot1.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01)
				disp1.show()
				disp1.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n == 1):
				plot2.show()
				plot2.frame = GVars.mushroomData.current[n] - 1
				plot2.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01)
				disp2.show()
				disp2.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n == 2):
				plot3.show()
				plot3.frame = GVars.mushroomData.current[n] - 1
				plot3.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01)
				disp3.show()
				disp3.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
			if(n ==3):
				plot4.show()
				plot4.frame = GVars.mushroomData.current[n] - 1
				plot4.scale = Vector2(1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01,1-(GVars.mushroomData.timeLeft[n]/(GVars.mushroomData.current[n]*15 + GVars.mushroomData.level * 10)) + 0.01)
				disp4.show()
				disp4.text = str(GVars.getScientific(GVars.mushroomData.timeLeft[n]))
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

func _check_xp():
	while(GVars.mushroomData.xp >= GVars.mushroomData.xpThresh):
		GVars.mushroomData.level += 1
		GVars.mushroomData.xp -= GVars.mushroomData.xpThresh
		GVars.mushroomData.xpThresh *= GVars.mushroomData.xpThreshMult
