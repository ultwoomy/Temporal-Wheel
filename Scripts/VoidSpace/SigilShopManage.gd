extends Container


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")
var failbought
var stupids
var altprice = 0
var sigilText = ["The Packsmith's token!\nUse it to make that grumpy\nold so and so do business\nwith you!",
				  "A warm candle!\nLights up your entire universe!",
				  "Reincarnation Ascension!\nI don't know what this does!\nMysteries are fun!",
				  "Emptiness!\nExtremely ironic name!\nFull of emoticon!",
				  "Ritual!\nEvery candle lit gives a buff!\nAnd lowers wheel spin speed!\nBe careful!",
				  "Dinner Hell!\nAccess a wonderful new realm!\nDo you hear something?"]


#@ Onready Variables
@onready var sigilLabel : Label = $SigilLabel
@onready var buyButton : Button = $BuyButton
@onready var sigilDisplay : AnimatedSprite2D = $SigilDisplay


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	print(str(GVars.hellChallengeLayer2))
	stupids = 0
	sigilDisplay.hide()
	sigilLabel.position = Vector2(500,300)
	sigilLabel.size = Vector2(400,200)
	buyButton.size = Vector2(100,100)
	buyButton.position = Vector2(850,380)
	reset()
	buyButton.pressed.connect(self._buttonPressed)


#@ Private Methods
func _buttonPressed():
	GVars._dialouge(sigilLabel, 0, 0.02)
	if failbought:
		reset()
	else:
		if ((GVars.spinData.spin > GVars.sigilData.costSpin) && (GVars.spinData.rotations > GVars.sigilData.costRot)) and not GVars.hellChallengeLayer2 == 1:
			GVars.spinData.spin -= GVars.sigilData.costSpin
			GVars.spinData.rotations -= GVars.sigilData.costRot
			checkCurrentSigil()
		elif GVars.hellChallengeLayer2 == 1 and not GVars.sigilData.numberOfSigils[0] and GVars.spinData.spin >= 1000:
			GVars.spinData.spin -= 1000
			checkCurrentSigil()
		elif GVars.hellChallengeLayer2 == 1 and not GVars.sigilData.numberOfSigils[1] and GVars.rustData.rust >= 20:
			GVars.rustData.rust -= 20
			checkCurrentSigil()
		elif GVars.hellChallengeLayer2 == 1 and not GVars.sigilData.numberOfSigils[2]:
			if not GVars.altSigilSand and GVars.mushroomData.level >= 6:
				GVars.mushroomData.level -= 5
				checkCurrentSigil()
			elif GVars.altSigilSand and GVars.dollarData.dollarTotal >= 5:
				GVars.dollarTotal -= 5
				checkCurrentSigil()
		elif GVars.hellChallengeLayer2 == 1 and not GVars.sigilData.numberOfSigils[3] and GVars.spinData.size > 4:
			GVars.spinData.size -= 4
			checkCurrentSigil()
		elif GVars.hellChallengeLayer2 == 1 and not GVars.sigilData.numberOfSigils[4] and GVars.Aspinbuff >= 7:
			GVars.Aspinbuff -= 6
			checkCurrentSigil()
		elif GVars.hellChallengeLayer2 == 1 and not GVars.sigilData.numberOfSigils[5] and GVars.kbityData.kbityLevel > 0:
			checkCurrentSigil()
		else :
			checkStupid()


func checkCurrentSigil():
	GVars.sigilData.costSpin = pow(GVars.sigilData.costSpin,GVars.sigilData.costSpinScale)
	GVars.sigilData.costRot *= GVars.sigilData.costRotScale
	var curSigil = 0
	while GVars.sigilData.numberOfSigils[curSigil]:
		curSigil += 1
	if(curSigil <= 5):
		sigilLabel.text = sigilText[curSigil]
	else :
		sigilLabel.text = "Use it well!"
	GVars.sigilData.numberOfSigils[curSigil] = true
	buyButton.text = "Thx"
	sigilDisplay.show()
	sigilDisplay.frame = curSigil
	failbought = true


func reset():
	if(GVars.sigilData.numberOfSigils[5]):
		sigilLabel.text = "We're out lmao."
		buyButton.hide()
	elif not GVars.hellChallengeLayer2 == 1 :
		sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n" + str(GVars.getScientific(GVars.sigilData.costSpin)) + " momentum\n" + str(GVars.getScientific(GVars.sigilData.costRot)) + " rotations"
		buyButton.text = "Buy"
		failbought = false
	else:
		var curSigil = 0
		while GVars.sigilData.numberOfSigils[curSigil]:
			curSigil += 1
		if curSigil == 0:
			sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n1000 momentum"
		elif curSigil == 1:
			sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n20 rust"
		elif curSigil == 2:
			if not GVars.altSigilSand:
				sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n5 mush levels\nYou'll need 6."
			else:
				sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n5 sand dollars"
		elif curSigil == 3:
			sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n4 size\nYou'll need 5."
		elif curSigil == 4:
			sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n6 identity\nYou'll need 7"
		elif curSigil == 5:
			altprice = 100
			sigilLabel.text = "Here for a sigil?\nFully charge the kbity machine and I'll give it to you"
		buyButton.text = "Buy"
		failbought = false


func checkStupid():
	if(stupids == 0):
		sigilLabel.text = "You can't afford that stupid."
		stupids += 1
	elif(stupids == 1):
		sigilLabel.text = "Guess what? You can't afford that."
		stupids += 1
	elif(stupids == 2):
		sigilLabel.text = "Yup. Still broke."
		stupids += 1
	elif(stupids == 3):
		sigilLabel.text = "Not much has changed."
		stupids += 1
	elif(stupids == 4):
		sigilLabel.text = "You still can't afford that."
		stupids += 1
	elif(stupids == 5):
		sigilLabel.text = "And you're still stupid."
		stupids += 1
	elif(stupids == 6):
		sigilLabel.text = "Kidding! You can afford that now!"
		stupids += 1
	elif(stupids == 7):
		sigilLabel.text = "Not really."
		stupids += 1
	elif(stupids == 8):
		sigilLabel.text = "But one day you will."
		stupids += 1
	elif(stupids == 9):
		sigilLabel.text = "Maybe."
		stupids += 1
	elif(stupids == 10):
		sigilLabel.text = "Do you like secrets?"
		stupids += 1
	elif(stupids == 15):
		sigilLabel.text = "I think you like secrets."
		stupids += 1
	elif(stupids == 20):
		sigilLabel.text = "You must have a lot of free time."
		stupids += 1
	elif(stupids == 21):
		sigilLabel.text = "Good for you. It doesn't last."
		stupids += 1
	elif(stupids == 22):
		sigilLabel.text = "Unless you literally make time."
		stupids += 1
	elif(stupids == 23):
		sigilLabel.text = "Now I'm the stupid one."
		stupids += 1
	elif(stupids == 24):
		sigilLabel.text = "This doesn't make you less broke."
		stupids += 1
	elif(stupids == 25):
		sigilLabel.text = "Just vaguely annoying."
		stupids += 1
	elif(stupids == 30):
		sigilLabel.text = "I'm going to stop you here."
	else:
		sigilLabel.text = "I like secrets!"
		stupids += 1
	buyButton.text = "Oh"
	failbought = true
