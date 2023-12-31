extends Node
@export var inspect : Button
@export var augment : Button
@export var upgrade : Button
@export var automate : Button
@export var text : Label
@export var selection : Sprite2D
@export var upgrademenu : Sprite2D
@export var automationmenu : Sprite2D
@export var sigil01sprite : Sprite2D
@export var sigil02sprite : Sprite2D
@export var sigil03sprite : Sprite2D
@export var sigil04sprite : Sprite2D
@export var sigil05sprite : Sprite2D
@export var sigil06sprite : Sprite2D
@export var sigil01button : Button
@export var sigil02button : Button
@export var sigil03button : Button
@export var sigil04button : Button
@export var sigil05button : Button
@export var sigil06button : Button
@export var upgrade1 : Button
@export var upgrade2 : Button
@export var upgrade3 : Button
@export var upgrade4 : Button
@export var up1text : Label
@export var up2text : Label
@export var up3text : Label
@export var up4text : Label
@export var rDisplay : Label
@export var sigilDisplay : AnimatedSprite2D
@export var next : Button
@export var packback :AnimatedSprite2D
var ifinspect = false
var ifinmen = false
var ifbuff = false
var inmenu = false
var ifupscreen = false
var ifautomascreen = false
var line = 0
var mode = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	rDisplay.position = Vector2(-190,0)
	rDisplay.text = str(GVars.getScientific(GVars.rustData.rust))
	inspect.size = Vector2(400,50)
	inspect.position = Vector2(100,100)
	augment.size = Vector2(400,50)
	augment.position = Vector2(100,150)
	upgrade.size = Vector2(400,50)
	upgrade.position = Vector2(100,200)
	automate.size = Vector2(400,50)
	automate.position = Vector2(100,250)
	inspect.text = "Inspect"
	augment.text = "Augment"
	upgrade.text = "Upgrade"
	automate.text = "Automate"
	upgrademenu.hide()
	if(GVars.hellChallengeNerf > 0) or (GVars.ifhell):
		automate.show()
	else:
		automate.hide()
	automationmenu.hide()
	upgrade1.size = Vector2(350,150)
	upgrade1.position = Vector2(15,-50)
	upgrade2.size = Vector2(350,150)
	upgrade2.position = Vector2(-50,-50)
	upgrade3.size = Vector2(350,150)
	upgrade3.position = Vector2(-50,35)
	upgrade4.size = Vector2(350,150)
	upgrade4.position = Vector2(15,35)
	upgrade1.text = "Increase Spin Per Click"
	upgrade2.text = "Increase Hunger Per Tick"
	upgrade3.text = "Increase Rust Per Drop"
	if(GVars.curEmotionBuff == 0):
		upgrade4.hide()
	elif(GVars.curEmotionBuff == 1):
		#fear
		upgrade4.text = "Increase Wheel Spin Rate Per\nRotation"
	elif(GVars.curEmotionBuff == 2):
		#cold
		upgrade4.text = "Increase Hunger By Percentage\nOf Momentum Needed For\nNext Size"
	elif(GVars.curEmotionBuff == 3):
		#warmth
		upgrade4.text = "Increase Mushroom\nExperience Gain"
	elif(GVars.curEmotionBuff == 4):
		#wrath
		upgrade4.text = "Increase Effect Of Rust\nUpgrades"
	up1text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin))
	up2text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger))
	up3text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust))
	up4text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
	upgrade1.pressed.connect(self._up01)
	upgrade2.pressed.connect(self._up02)
	upgrade3.pressed.connect(self._up03)
	upgrade4.pressed.connect(self._up04)
	next.size = Vector2(100,100)
	next.position = Vector2(390,420)
	next.text = "Next"
	next.hide()
	inspect.pressed.connect(self._inspect)
	augment.pressed.connect(self._augment)
	upgrade.pressed.connect(self._upgrade)
	automate.pressed.connect(self._automate)
	if(!GVars.sigilData.numberOfSigils[0]):
		inspect.hide()
		augment.hide()
		upgrade.hide()
		automate.hide()
		text.text = "No shirt, no sigil, no service."
	sigil01button.pressed.connect(self._01Sigil)
	sigil02button.pressed.connect(self._02Sigil)
	sigil03button.pressed.connect(self._03Sigil)
	sigil04button.pressed.connect(self._04Sigil)
	sigil05button.pressed.connect(self._05Sigil)
	sigil06button.pressed.connect(self._06Sigil)
	next.pressed.connect(self._nextline)
	selection.hide()
	updateDisplays()
func _inspect():
	ifinspect = true
	if(ifinmen == false):
		dispSigils()
		ifinmen = true
		inmenu = true
	else:
		selection.hide()
		ifinmen = false
		inmenu = false

func _augment():
	ifinspect = false
	if(ifbuff == false):
		dispSigils()
		ifbuff = true
		inmenu = true
	else:
		selection.hide()
		ifbuff = false
		inmenu = false

func dispSigils():
	selection.show()
	if(GVars.sigilData.numberOfSigils[1]):
		sigil02sprite.show()
		sigil02button.show()
	else:
		sigil02sprite.hide()
		sigil02button.hide()
	if(GVars.sigilData.numberOfSigils[2]):
		sigil03sprite.show()
		sigil03button.show()
	else:
		sigil03sprite.hide()
		sigil03button.hide()
	if(GVars.sigilData.numberOfSigils[3]):
		sigil04sprite.show()
		sigil04button.show()
	else:
		sigil04sprite.hide()
		sigil04button.hide()
	if(GVars.sigilData.numberOfSigils[4]):
		sigil05sprite.show()
		sigil05button.show()
	else:
		sigil05sprite.hide()
		sigil05button.hide()
	if(GVars.sigilData.numberOfSigils[5]):
		sigil06sprite.show()
		sigil06button.show()
	else:
		sigil06sprite.hide()
		sigil06button.hide()
	upgrademenu.hide()
	automationmenu.hide()
	resetWindowVars()

func _upgrade():
	if(ifupscreen == false):
		upgrademenu.show()
		selection.hide()
		automationmenu.hide()
		resetWindowVars()
		ifupscreen = true
		ifautomascreen = false
		inmenu = true
	else:
		upgrademenu.hide()
		ifupscreen = false
		inmenu = false

func _automate():
	if(ifautomascreen == false):
		automationmenu.show()
		selection.hide()
		upgrademenu.hide()
		resetWindowVars()
		ifautomascreen = true
		ifupscreen = false
		inmenu = true
	else:
		automationmenu.hide()
		ifautomascreen = false
		inmenu = false

func _01Sigil():
	manageChoice(1)
func _02Sigil():
	manageChoice(2)
func _03Sigil():
	manageChoice(3)
func _04Sigil():
	manageChoice(4)
func _05Sigil():
	manageChoice(5)
func _06Sigil():
	manageChoice(6)
	
func resetWindowVars():
	inmenu = false
	ifupscreen = false
	ifbuff = false
	ifinmen = false
func resetChoice():
	text.text = ""
	packback.frame = 2
	line = 0
	resetWindowVars()
	inspect.show()
	augment.show()
	upgrade.show()
	if(GVars.hellChallengeNerf > 0) or (GVars.ifhell):
		automate.show()
	next.hide()
	
func updateDisplays():
	if(GVars.curEmotionBuff == 4):
		up1text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin * GVars.rustData.fourth))
		up2text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger * GVars.rustData.fourth))
		up3text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust * GVars.rustData.fourth))
		up4text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
	else:
		up1text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin))
		up2text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger))
		up3text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust))
		up4text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
	rDisplay.text = str(GVars.getScientific(GVars.rustData.rust))
func _up01():
	if(GVars.rustData.rust >= GVars.rustData.increaseSpinCost):
		GVars.rustData.rust -= GVars.rustData.increaseSpinCost
		GVars.rustData.increaseSpinCost *= GVars.rustData.increaseSpinScaling
		GVars.rustData.increaseSpin += 1
		updateDisplays()
func _up02():
	if(GVars.rustData.rust >= GVars.rustData.increaseHungerCost):
		GVars.rustData.rust -= GVars.rustData.increaseHungerCost
		GVars.rustData.increaseHungerCost *= GVars.rustData.increaseHungerScaling
		GVars.rustData.increaseHunger += 1
		updateDisplays()
func _up03():
	if(GVars.rustData.rust >= GVars.rustData.increaseRustCost):
		GVars.rustData.rust -= GVars.rustData.increaseRustCost
		GVars.rustData.increaseRustCost *= GVars.rustData.increaseRustScaling
		GVars.rustData.increaseRust += 1
		GVars.rustData.perThresh += 1
		updateDisplays()
func _up04():
	if(GVars.rustData.rust >= GVars.rustData.fourthCost):
		GVars.rustData.rust -= GVars.rustData.fourthCost
		GVars.rustData.fourthCost *= GVars.rustData.fourthScaling
		if(GVars.curEmotionBuff == 1):
		#fear
			GVars.rustData.fourth += 0.03
		elif(GVars.curEmotionBuff == 2):
		#cold
			GVars.rustData.fourth += 0.02
		elif(GVars.curEmotionBuff == 3):
		#warmth
			GVars.rustData.fourth *= 1.5
		elif(GVars.curEmotionBuff == 4):
		#wrath
			GVars.rustData.fourth *= 1.2
		updateDisplays()
func manageChoice(n):
	GVars._dialouge(text,0,0.04)
	selection.hide()
	inspect.hide()
	augment.hide()
	upgrade.hide()
	automate.hide()
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
		elif(n == 4):
			text.text = "A vague memory of a face."
			mode = 4
		elif(n == 5):
			text.text = "A relic from hell, the\nritual."
			mode = 5
		elif(n == 6) and !GVars.ifhell:
			text.text = "Oh hey, it's the sigil of a\nblue baby."
			mode = 6
		elif(n == 6):
			text.text = "Oh hey, it's the sigil of \nliteral Satan."
			mode = 25
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
		elif(n == 4):
			text.text = "I'm not entirely sure what\nyou want me to do with this."
			mode = 16
		elif(n == 5):
			text.text = "This one's easy, I can just\nreplace one of these\ncandles with one of mine."
			mode = 17
		elif(n == 6) and !GVars.ifhell:
			text.text = "There's a powerful contract\netched into this sigil."
			mode = 18
		elif(n == 6):
			text.text = "Surprise surprise! It's more\ncontracts!"
			mode = 26
func _nextline():
	GVars._dialouge(text,0,0.04)
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
	elif(mode == 4):
		if(line == 0):
			text.text = "It's honestly kind of creepy\nthat you have this."
			packback.frame = 5
			line += 1
		elif(line == 1):
			text.text = "Wearing this will amplify an\nemotion of your choice\nto a ridiculous degree."
			packback.frame = 2
			line += 1
		elif(line == 2):
			text.text = "To the point where it persists\nafter death."
			line += 1
		elif(line == 3):
			text.text = "...You'd have to wear it\nthough.\nEw."
			line += 1
		elif(line == 4):
			text.text = ""
			resetChoice()
	elif(mode == 5):
		if(line == 0):
			text.text = "It represents a deal with\nthe devil, though the\ndevil happens to be dead."
			packback.frame = 5
			line += 1
		elif(line == 1):
			text.text = "So it's peculiar that this\nis working at all."
			packback.frame = 2
			line += 1
		elif(line == 2):
			text.text = "Maybe a new one spawned in."
			line += 1
		elif(line == 3):
			text.text = "Each deal has a cost,\nbut the price seems\npretty low for you."
			line += 1
		elif(line == 4):
			text.text = "You got lucky."
			line += 1
		elif(line == 5):
			text.text = ""
			resetChoice()
	elif(mode == 6):
		if(line == 0):
			text.text = "It's representative of the\nservants of Divine."
			line += 1
		elif(line == 1):
			text.text = "You could probably use this\nto get into heaven."
			line += 1
		elif(line == 2):
			text.text = "...actually there's no perm\nfor that in here."
			line += 1
		elif(line == 3):
			text.text = "Huh, guess it's useless then."
			line += 1
		elif(line == 4):
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
			text.text = "The warm glow should make\nshrooms grow twice as\nfast."
			line += 1
		elif(line == 1):
			text.text = "Which makes no sense since\nthey like dim lighting."
			packback.frame = 3
			line += 1
		elif(line == 2):
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
			text.text = "It seems to be sucking in\nmomentum at an increased\nrate."
			line += 1
		elif(line == 3):
			text.text = "I barely touched it I swear."
			packback.frame = 4
			line += 1
		elif(line == 4):
			resetDisplay(3)
			resetChoice()
	elif(mode == 16):
		if(line == 0):
			text.text = "You're going to wear that?\nReally?."
			packback.frame = 4
			line += 1
		elif(line == 1):
			text.text = "..."
			packback.frame = 5
			line += 1
		elif(line == 2):
			text.text = "It uh, looks good on you\nI think?"
			packback.frame = 2
			line += 1
		elif(line == 3):
			resetDisplay(4)
			resetChoice()
	elif(mode == 17):
		if(line == 0):
			text.text = "Now the first candle you\nLight is free."
			packback.frame = 4
			line += 1
		elif(line == 1):
			resetDisplay(5)
			resetChoice()
	elif(mode == 18):
		if(line == 0):
			text.text = "I can start this contract\nfor you, but be warned."
			packback.frame = 4
			line += 1
		elif(line == 1):
			text.text = "This thing is tough, even\nstarting it requires\neverything you've gotten\nup till now."
			line += 1
		elif(line == 2):
			text.text = "It will invert the effect\nof your current emotion\nturning it into a debuff."
			line += 1
			packback.frame = 2
		elif(line == 3):
			if(GVars.curEmotionBuff == 1):
				#fear
				text.text = "Rotations will divide\nyour wheel's spin speed."
			elif(GVars.curEmotionBuff == 2):
				#cold
				text.text = "The effect of size is\nsquare rooted."
			elif(GVars.curEmotionBuff == 3):
				#warmth
				text.text = "The effects of mushrooms\nare greatly decreased."
			elif(GVars.curEmotionBuff == 4):
				#wrath
				text.text = "You will get a max of 1\nrust per rust drop."
			else:
				text.text = "Which is no nerf at all\nLol, nice one."
			line += 1
		elif(line == 4):
			text.text = "This will persist until\nyou regain this sigil."
			line += 1
		elif(line == 5):
			text.text = "If you don't want to\ndo this yet, it's ok\nto just leave."
			line += 1
		elif(line == 6):
			text.text = "Alright, good luck."
			packback.frame = 1
			line += 1
		elif(line == 7):
			resetDisplay(6)
			resetChoice()
	elif(mode == 25):
		if(line == 0):
			text.text = "You really pick up a lot\nof weird things don't you."
			line += 1
		elif(line == 1):
			text.text = "I'm out of the loop with\nhistory.\nI fear my knowledge can't\nkeep up."
			line += 1
		elif(line == 2):
			text.text = "How about you tell me the\nlatest whenever you visit."
			line += 1
		elif(line == 3):
			resetChoice()
	elif(mode == 26):
		if(line == 0):
			text.text = "Be warned though, these\ncontracts mean business."
			line += 1
		elif(line == 1):
			text.text = "These will be harder than\nanything else the blue\nguy's cooked up for you."
			line += 1
		elif(line == 2):
			text.text = "But I(the developer) am not\nthere yet, so."
			line += 1
		elif(line == 3):
			text.text = "WHO SAID THAT!?"
			line += 1
		elif(line == 4):
			resetDisplay(0)
			resetChoice()
	else:
		text.text = ""
		resetChoice()


func resetDisplay(n: int):
	if(n == 6) and !GVars.ifhell:
		GVars.sigilData.curSigilBuff = n
		get_tree().change_scene_to_file("res://Scenes/AscensionSpace.tscn")
	GVars.sigilData.curSigilBuff = n
	sigilDisplay.frame = GVars.sigilData.curSigilBuff - 1
	sigilDisplay.show()
	


