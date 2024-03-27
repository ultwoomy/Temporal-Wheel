extends Node


@export var inspect : Button
@export var augment : Button
@export var upgrade : Button
@export var automate : Button
@export var text : Label
@onready var selection : SelectionMenu = $SelectionMenu
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


var inspecting: bool = false
var ifinmen = false
var ifbuff = false
var inmenu = false
var ifupscreen = false
var ifautomascreen = false
var line = 0
var mode = 0
var sigilToActivate = 0
var packscript = ["That's my sigil.",
				  "All sigils are kind of like...\npermissions of sorts.",
				  "All this one does is let you\ntalk to me.",
				  "...Stop looking disappointed\nit's a high honor!",
				
				  "A lovely candle.",
				  "It's sufficient to light any\nspace.",
				  "You'll likely be able to see\nthings back home you \ncouldn't before",
				
				  "Looks like a portal or\nsomething.",
				  "Not sure exactly what it does\nbut.",
				  "It's attached itself to your\nwheel",
				  "Clicking on the wheel should\ntell you more.",
				
				  "A vague memory of a face.",
				  "It's honestly kind of creepy\nthat you have this.",
				  "Wearing this will amplify an\nemotion of your choice\nto a considerable degree.",
				  "To the point where it persists\nafter death.",
				  "...You'd have to wear it\nthough.\nEw.",
				
				  "A relic from hell, the\nritual.",
				  "It represents a deal with\nthe devil, though the\ndevil happens to be dead.",
				  "So it's peculiar that this\nis working at all.",
				  "Maybe a new one spawned in.",
				
				  "Oh hey, it's the sigil of a\nblue baby.",
				  "Those things are the\nservants of Divine.",
				  "You could probably use this\nto get into heaven!",
				  "...actually there's no perm\nfor that in here.\nGuess it's useless then.",
				
				  "Now it's a rust magnet.",
				  "You should get more rust\nfrom that wheel now.",
				
				  "I've increased the strength\n of the light.",
				  "The warm glow should make\nshrooms grow twice as\nfast.",
				  "Which makes no sense since\nthey like dim lighting.",
				
				  "I don't think I know enough\nto touch this.",
				  "Lemme just uh.",
				  "Oops.",
				  "It seems to be sucking in\nmomentum at an increased\nrate.",
				  "I barely touched it I swear.",
				
				  "I'm not entirely sure what\nyou want me to do with this.",
				  "You're going to wear that?\nReally?.",
				  "...",
				  "It uh, looks good on you\nI think?",
				
				  "This one's easy, I can just\nreplace one of these\ncandles with one of mine.",
				  "Now the first candle you\nLight is free.",
				  "I'm not giving you any more.",
				
				  "There's a powerful contract\netched into this sigil.",
				  "I can start this contract\nfor you, but be warned.",
				  "This thing is tough, even\nstarting it requires\neverything you've gotten\nup till now.",
				  "It will invert the effect\nof your current emotion\nturning it into a debuff.",
				  "What exactly that is...\nEh, you'll find out.",
				  "This will persist until\nyou regain this sigil\nand augment it again.",
				  "If you don't want to\ndo this yet, it's ok\nto just leave.",
				  "Alright, good luck.",
				
				  "There's a powerful contract\netched into this sigil.",
				  "I can start this contract\nfor you, but...",
				  "You've already finished it\nsomehow. Huh.",
				  "Well good for you, you've\nbeen updated.",
				  "Go ahead and try entering\nhell now.",
				
				  "I can draw out the power\nof the blue babies and\nmake you immortal!!",
				  "It's not implemented yet so\nI don't have to explain\nshit."]
				
var endofline = [false,false,false,true,
				 false,false,true,
				 false,false,false,true,
				 false,false,false,false,true,
				 false,false,false,true,
				 false,false,false,true,
				 false,true,
				 false,false,true,
				 false,false,false,false,true,
				 false,false,false,true,
				 false,false,true,
				 false,false,false,false,false,false,false,true,
				 false,false,false,false,true,
				 false,true]
				
var emote = [2,2,2,3,
			 2,2,2,
			 4,2,2,2,
			 2,4,2,4,5,
			 2,2,2,2,
			 2,2,2,2,
			 2,2,
			 2,2,3,
			 2,2,4,4,2,
			 2,4,5,2,
			 4,2,5,
			 2,2,4,2,2,2,2,1,
			 2,2,4,2,1,
			 3,0]
				
var convoNo = [0,4,7,11,16,20,24,26,29,34,38,41,49,54,0]
var convoStart = false
var pos = 0


func nextLin(m):
	GVars._dialouge(text,0,0.04)
	if !convoStart:
		pos = convoNo[m]
		text.text = packscript[pos]
		packback.frame = emote[pos]


func nextLine():
	GVars._dialouge(text,0,0.04)
	if endofline[pos]:
		pos = 0
		text.text = ""
		packback.frame = 2
		resetChoice()
		if(sigilToActivate != 0):
			resetDisplay(sigilToActivate)
			sigilToActivate = 0
	else: 
		pos += 1
		text.text = packscript[pos]
		packback.frame = emote[pos]


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
	if(GVars.curEmotionBuff < 0) or (GVars.curEmotionBuff > 4):
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
	
	### PacksmithSelectionMenu's buttons.
	selection.sigil_button_pressed.connect(_on_sigil_button_pressed)
	###
	
	next.pressed.connect(self.nextLine)
	selection.hide()
	updateDisplays()


func _inspect():
	inspecting = true
	if(ifinmen == false):
		dispSigils()
		ifinmen = true
		inmenu = true
	else:
		selection.hide()
		ifinmen = false
		inmenu = false


func _augment():
	inspecting = false
	if(ifbuff == false):
		dispSigils()
		ifbuff = true
		inmenu = true
	else:
		selection.hide()
		ifbuff = false
		inmenu = false

### WIP: How will I move this to PacksmithSelectionMenu?
func dispSigils():
	selection.show()
	
	selection.display_sigils()
#	if(GVars.sigilData.numberOfSigils[1]):
#		sigil02sprite.show()
#		sigil02button.show()
#	else:
#		sigil02sprite.hide()
#		sigil02button.hide()
#	if(GVars.sigilData.numberOfSigils[2]):
#		sigil03sprite.show()
#		sigil03button.show()
#	else:
#		sigil03sprite.hide()
#		sigil03button.hide()
#	if(GVars.sigilData.numberOfSigils[3]):
#		sigil04sprite.show()
#		sigil04button.show()
#	else:
#		sigil04sprite.hide()
#		sigil04button.hide()
#	if(GVars.sigilData.numberOfSigils[4]):
#		sigil05sprite.show()
#		sigil05button.show()
#	else:
#		sigil05sprite.hide()
#		sigil05button.hide()
#	if(GVars.sigilData.numberOfSigils[5]):
#		sigil06sprite.show()
#		sigil06button.show()
#	else:
#		sigil06sprite.hide()
#		sigil06button.hide()
	
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


func _on_sigil_button_pressed(sigil: SigilData.Sigils) -> void:
	match sigil:
		SigilData.Sigils.PACKSMITH:
			manageChoice(1)
		SigilData.Sigils.CANDLE:
			manageChoice(2)
		SigilData.Sigils.ASCENSION:
			manageChoice(3)
		SigilData.Sigils.EMPTINESS:
			manageChoice(4)
		SigilData.Sigils.RITUAL:
			manageChoice(5)
		SigilData.Sigils.HELL:
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
	if(inspecting):
		if(n == 1):
			nextLin(0)
		elif(n == 2):
			nextLin(1)
		elif(n == 3):
			nextLin(2)
		elif(n == 4):
			nextLin(3)
		elif(n == 5):
			nextLin(4)
		elif(n == 6):
			nextLin(5)
	if(!inspecting):
		if(n == 1):
			nextLin(6)
			sigilToActivate = 1
		elif(n == 2):
			nextLin(7)
			sigilToActivate = 2
		elif(n == 3):
			nextLin(8)
			sigilToActivate = 3
		elif(n == 4):
			nextLin(9)
			sigilToActivate = 4
		elif(n == 5):
			nextLin(10)
			sigilToActivate = 5
		elif(n == 6):
			if(GVars.hellChallengeNerf < 0):
				if(!GVars.ifhell):
					nextLin(11)
					sigilToActivate = 6
				else:
					nextLin(13)
					sigilToActivate = 6
			else:
				nextLin(12)
				sigilToActivate = 6
				GVars.ifhell = true
				GVars.inContract = false
				GVars.hellChallengeNerf = -1


func resetDisplay(n: int):
	sigilToActivate = 0
	if(n == 6) and !GVars.ifhell:
		GVars.sigilData.curSigilBuff = n
		get_tree().change_scene_to_file("res://Scenes/AscensionSpace.tscn")
	GVars.sigilData.curSigilBuff = n
	sigilDisplay.frame = GVars.sigilData.curSigilBuff - 1
	sigilDisplay.show()
	


