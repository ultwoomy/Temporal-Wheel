extends Node
@export var inspect : Button
@export var augment : Button
@export var upgrade : Button
@export var text : Label
@export var selection : Sprite2D
@export var upgrademenu : Sprite2D
@export var sigil01button : Button
@export var sigil02button : Button
@export var sigil03button : Button
@export var upgrade1 : Button
@export var upgrade2 : Button
@export var upgrade3 : Button
@export var sigilDisplay : AnimatedSprite2D
@export var next : Button
@export var packback :AnimatedSprite2D
var ifinspect = false
var inmenu = false
var line = 0
var mode = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	inspect.size = Vector2(400,50)
	inspect.position = Vector2(100,100)
	augment.size = Vector2(400,50)
	augment.position = Vector2(100,150)
	upgrade.size = Vector2(400,50)
	upgrade.position = Vector2(100,200)
	inspect.text = "Inspect"
	augment.text = "Augment"
	upgrade.text = "Upgrade"
	upgrademenu.hide()
	upgrade1.size = Vector2(350,150)
	upgrade1.position = Vector2(0,-50)
	upgrade2.size = Vector2(350,150)
	upgrade2.position = Vector2(-50,-50)
	upgrade3.size = Vector2(350,150)
	upgrade3.position = Vector2(-50,0)
	upgrade1.text = "Increase Spin Per Click"
	upgrade2.text = "Increase Hunger Per Tick"
	upgrade3.text = "Increase Rust Per Drop"
	next.size = Vector2(100,100)
	next.position = Vector2(370,410)
	next.text = "Next"
	next.hide()
	inspect.pressed.connect(self._inspect)
	augment.pressed.connect(self._augment)
	upgrade.pressed.connect(self._upgrade)
	sigil01button.pressed.connect(self._01Sigil)
	sigil02button.pressed.connect(self._02Sigil)
	sigil03button.pressed.connect(self._03Sigil)
	next.pressed.connect(self._nextline)
	selection.hide()
func _inspect():
	selection.show()
	ifinspect = true
	inmenu = true

func _augment():
	selection.show()
	ifinspect = false
	inmenu = true

func _upgrade():
	upgrademenu.show()
	inmenu = true

func _01Sigil():
	manageChoice(1)
func _02Sigil():
	manageChoice(2)
func _03Sigil():
	manageChoice(3)
	
func resetChoice():
	text.text = ""
	packback.frame = 2
	line = 0
	inspect.show()
	augment.show()
	upgrade.show()
	next.hide()
	
func manageChoice(n):
	selection.hide()
	inspect.hide()
	augment.hide()
	upgrade.hide()
	next.show()
	text.show()
	if(ifinspect):
		if(n == 1):
			text.text = "That's my sigil."
			mode = 1
		elif(n == 2):
			text.text = "A lovely candle."
			mode = 2
		elif(n == 3):
			text.text = "Looks like a portal or\nsomething."
			mode = 3
	if(!ifinspect):
		if(n == 1):
			text.text = "Now it's a rust magnet."
			mode = 13
		elif(n == 2):
			text.text = "I've increased the strength\n of the light."
			mode = 14
		elif(n == 3):
			text.text = "I don't think I know enough\nto touch this."
			mode = 15
func _nextline():
	if(mode == 1):
		if(line == 0):
			text.text = "All sigils are kind of like...\npermissions of sorts."
			line += 1
		elif(line == 1):
			text.text = "All this one does is let you\ntalk to me."
			line += 1
		elif(line == 2):
			text.text = "...Stop looking disappointed\nit's a high honor!"
			packback.frame = 3
			line += 1
		elif(line == 3):
			text.text = ""
			resetChoice()
	elif(mode == 2):
		if(line == 0):
			text.text = "It's sufficient to light any\nspace."
			line += 1
		elif(line == 1):
			text.text = "You'll likely be able to see\nthings back home you \ncouldn't before"
			line += 1
		elif(line == 2):
			text.text = ""
			resetChoice()
	elif(mode == 3):
		if(line == 0):
			text.text = "Not sure exactly what it does\nbut."
			packback.frame = 2
			line += 1
		elif(line == 1):
			text.text = "It's attached itself to your\nwheel"
			line += 1
		elif(line == 2):
			text.text = "Clicking on the wheel should\ntell you more."
			line += 1
		elif(line == 3):
			text.text = ""
			resetChoice()
	elif(mode == 13):
		if(line == 0):
			text.text = "You should get more rust\nfrom that wheel now."
			line += 1
		elif(line == 1):
			resetDisplay(1)
			resetChoice()
	elif(mode == 14):
		if(line == 0):
			text.text = "The warm grow should make\nshrooms grow faster."
			line += 1
		elif(line == 1):
			text.text = "Which makes no sense since\nthey like dim lighting."
			packback.frame = 3
			line += 1
		elif(line == 2):
			GVars.curSigilBuff = 2
			resetDisplay(2)
			resetChoice()
	elif(mode == 15):
		if(line == 0):
			text.text = "Lemme just uh."
			line += 1
		elif(line == 1):
			text.text = "Oops."
			line += 1
		elif(line == 2):
			text.text = "It seems to be sucking in\nmatter at an increased\nrate."
			line += 1
		elif(line == 3):
			text.text = "I barely touched it I swear."
			packback.frame = 4
			line += 1
		elif(line == 4):
			resetDisplay(3)
			resetChoice()
	else:
		text.text = ""
		resetChoice()
func resetDisplay(n):
	GVars.curSigilBuff = n
	sigilDisplay.frame = GVars.curSigilBuff - 1
	sigilDisplay.show()
	


