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
	for n in GVars.Scurrent.size():
		GVars.StimeLeft[n] -= GVars.SpendingRots
		if(GVars.StimeLeft[n] <= 0):
			GVars.StimeLeft[n] = 0
	_update_sprites()
	GVars.SpendingRots = 0
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
	for n in GVars.Scurrent.size():
		if(GVars.Scurrent[n] == 0):
			GVars.Scurrent[n] = curFrame + 1
			if(GVars.curSigilBuff == 2):
				GVars.StimeLeft[n] = (curFrame + 1) * 10 + GVars.SmushLevel * 8
			else:
				GVars.StimeLeft[n] = (curFrame + 1) * 15 + GVars.SmushLevel * 10
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
	xpbar.scale.x = GVars.Sxp/GVars.Sxpthresh*1.5
	leveldisp.text = "Level: " + str(GVars.getScientific(GVars.SmushLevel))
	statsdisp.text = "Buffs\nSpin Buff: " + str(GVars.getScientific(GVars.Sspinbuff)) + "\nIdentity Buff: " + str(GVars.getScientific(GVars.Sascbuff))
	for n in GVars.Scurrent.size():
		if(GVars.Scurrent[n] != 0):
			if(n == 0):
				plot1.show()
				plot1.frame = GVars.Scurrent[n] - 1
				plot1.scale = Vector2(1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01,1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01)
				disp1.show()
				disp1.text = str(GVars.getScientific(GVars.StimeLeft[n]))
			if(n == 1):
				plot2.show()
				plot2.frame = GVars.Scurrent[n] - 1
				plot2.scale = Vector2(1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01,1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01)
				disp2.show()
				disp2.text = str(GVars.getScientific(GVars.StimeLeft[n]))
			if(n == 2):
				plot3.show()
				plot3.frame = GVars.Scurrent[n] - 1
				plot3.scale = Vector2(1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01,1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01)
				disp3.show()
				disp3.text = str(GVars.getScientific(GVars.StimeLeft[n]))
			if(n ==3):
				plot4.show()
				plot4.frame = GVars.Scurrent[n] - 1
				plot4.scale = Vector2(1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01,1-(GVars.StimeLeft[n]/(GVars.Scurrent[n]*15 + GVars.SmushLevel * 10)) + 0.01)
				disp4.show()
				disp4.text = str(GVars.getScientific(GVars.StimeLeft[n]))
func _harvest():
	for n in GVars.Scurrent.size():
		if(GVars.Scurrent[n] != 0) and (GVars.StimeLeft[n] <= 0):
			_harvest_shroom(GVars.Scurrent[n])
			GVars.Scurrent[n] = 0
			GVars.StimeLeft[n] = 0
			_update_sprites()
			
func _harvest_shroom(val):
	var Ebuff = 1
	if(GVars.curEmotionBuff == 3):
		Ebuff = (log(GVars.rotations))/2 + 0.5
	if(val == 1):
		GVars.spin += GVars.spinPerClick * GVars.size * GVars.density * GVars.Rincreasespin * GVars.Sspinbuff * GVars.SmushLevel * 20
		GVars.Sxp += 25 * Ebuff
	elif(val == 2):
		GVars.rotations += GVars.SmushLevel * 3
		GVars.Sxp += 50 * Ebuff
	elif(val == 3):
		GVars.Sspinbuff += (3 * (log(GVars.SmushLevel + 1)/log(3)))/(pow(2,GVars.Sspinbuff))
		GVars.Sxp += 75 * Ebuff
	elif(val == 4):
		GVars.Sascbuff += (log(GVars.SmushLevel + 1)/log(3))/(pow(2,GVars.Sascbuff))
		GVars.Sxp += 100 * Ebuff
	_check_xp()

func _check_xp():
	while(GVars.Sxp >= GVars.Sxpthresh):
		GVars.SmushLevel += 1
		GVars.Sxp -= GVars.Sxpthresh
		GVars.Sxpthresh *= GVars.Sxpthreshmult
