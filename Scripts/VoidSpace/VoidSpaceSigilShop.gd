extends Control
class_name VoidSpaceSigilShop


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")
var failbought
var stupids : int = 0
var altprice = 0
var sigilText = ["The Packsmith's token!\nUse it to make that grumpy\nold so and so do business\nwith you!",
				  "A warm candle!\nLights up your entire universe!",
				  "Reincarnation Ascension!\nI don't know what this does!\nMysteries are fun!",
				  "Emptiness!\nExtremely ironic name!\nFull of emoticon!",
				  "Ritual!\nEvery candle lit gives a buff!\nAnd lowers wheel spin speed!\nBe careful!",
				  "Dinner Hell!\nAccess a wonderful new realm!\nDo you hear something?",
				  "",
				  "",
				  "",
				  "Sand Dollar!\nPick them and knock them down!\nThey're just along for the ride!",
				  "Zunda Of The Night\nI don't know how I have this!\nIt's probably ok!\nNON FUNCTIONAL",
				  "Undercity!\nThe birthplace of fae and fun!\nIsn't this themeing reused?\nNON FUNCTIONAL",
				  "Twin Rose!\nDon't let them intimidate you!\nThey're actually quite nice!\nNON FUNCTIONAL"]

var sigilPurchaseOrder : SigilPurchaseOrder = GVars.currentSigilOrder


#@ Onready Variables
@onready var sigilLabel : Label = $SigilLabel
@onready var buyButton : Button = $BuyButton
@onready var button : Button = $BuyButton
@onready var sigilDisplay : AnimatedSprite2D = $SigilDisplay
@onready var sandLabel : Label = $SandLabel
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent  # Optional (it's not)
const packsmithSigil 	: Sigil = preload("res://Resources/Sigil/PacksmithSigil.tres")
const candleSigil 		: Sigil = preload("res://Resources/Sigil/CandleSigil.tres")
const ascensionSigil 	: Sigil = preload("res://Resources/Sigil/AscensionSigil.tres")
const emptinessSigil 	: Sigil = preload("res://Resources/Sigil/EmptinessSigil.tres")
const ritualSigil 		: Sigil = preload("res://Resources/Sigil/RitualSigil.tres")
const hellSigil 		: Sigil = preload("res://Resources/Sigil/HellSigil.tres")
const sandSigil      	: Sigil = preload("res://Resources/Sigil/SandDollar.tres")
const twinsSigil  	  	: Sigil = preload("res://Resources/Sigil/TwinsSigil.tres")
const undercitySigil 	: Sigil = preload("res://Resources/Sigil/UndercitySigil.tres")
const zundaNightSigil 	: Sigil = preload("res://Resources/Sigil/ZundaNightSigil.tres")
var acquiredPacksmithSigil 	: bool = GVars.sigilData.acquiredSigils.has(packsmithSigil)
var acquiredCandleSigil 	: bool = GVars.sigilData.acquiredSigils.has(candleSigil)
var acquiredAscensionSigil 	: bool = GVars.sigilData.acquiredSigils.has(ascensionSigil)
var acquiredEmptinessSigil 	: bool = GVars.sigilData.acquiredSigils.has(emptinessSigil)
var acquiredRitualSigil 	: bool = GVars.sigilData.acquiredSigils.has(ritualSigil)
var acquiredHellSigil 		: bool = GVars.sigilData.acquiredSigils.has(hellSigil)
var acquiredSandSigil		: bool = GVars.sigilData.acquiredSigils.has(sandSigil)
var acquiredtwinsSigil  	: bool = GVars.sigilData.acquiredSigils.has(twinsSigil)
var acquiredUndercitySigil	: bool = GVars.sigilData.acquiredSigils.has(undercitySigil)
var acquiredNightSigil 		: bool = GVars.sigilData.acquiredSigils.has(zundaNightSigil)


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	sigilDisplay.hide()
	sigilLabel.position = Vector2(500,200)
	sigilLabel.size = Vector2(400,200)
	buyButton.size = Vector2(200,100)
	buyButton.position = Vector2(730,450)
	sandLabel.position = Vector2(850,295)
	reset()
	
	# Connect signals.
	buyButton.pressed.connect(self._onButtonPressed)


#@ Private Methods
func _onButtonPressed():
	GVars._dialouge(sigilLabel, 0, 0.02)
	if failbought:
		reset()
	else:
		
		if ((GVars.spinData.spin > GVars.sigilData.costSpin) and (GVars.spinData.rotations > GVars.sigilData.costRot)) and not GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET):
			#If player is in the sand challenge, include sand cost in the sigil price
			if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
				if GVars.sand >= GVars.sandCost:
					GVars.sand -= GVars.sandCost
					GVars.sandCost += GVars.sandScaling
					GVars.spinData.spin -= GVars.sigilData.costSpin
					GVars.spinData.rotations -= GVars.sigilData.costRot
					checkCurrentSigil()
				else:
					checkStupid()
			else:
				# If player is not in a challenge, just use the normal costs
				GVars.spinData.spin -= GVars.sigilData.costSpin
				GVars.spinData.rotations -= GVars.sigilData.costRot
				checkCurrentSigil()
		# If player is in the bittersweet challenge, change the price to a custom value, everything under this text does this
		elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) and not GVars.sigilData.numberOfSigils[0] and GVars.spinData.spin >= 1000:
			GVars.spinData.spin -= 1000
			checkCurrentSigil()
		elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) and not acquiredCandleSigil and GVars.rustData.rust >= 20:
			GVars.rustData.rust -= 20
			checkCurrentSigil()
		elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) and not acquiredAscensionSigil:
			if not GVars.altSigilSand and GVars.mushroomData.level >= 6:
				GVars.mushroomData.level -= 5
				checkCurrentSigil()
			elif GVars.altSigilSand and GVars.dollarData.dollarTotal >= 5:
				GVars.dollarTotal -= 5
				checkCurrentSigil()
		elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) and not acquiredEmptinessSigil and GVars.spinData.size > 4:
			GVars.spinData.size -= 4
			checkCurrentSigil()
		elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) and not acquiredRitualSigil and GVars.Aspinbuff >= 7:
			GVars.Aspinbuff -= 6
			checkCurrentSigil()
		elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) and not acquiredHellSigil and GVars.kbityData.kbityLevel > 0:
			checkCurrentSigil()
		else:
			checkStupid()


func checkCurrentSigil():
	var indexFromAcquiredSigils : int = GVars.sigilData.acquiredSigils.size()
	GVars.sigilData.costSpin = pow(GVars.sigilData.costSpin,GVars.sigilData.costSpinScale)
	GVars.sigilData.costRot *= GVars.sigilData.costRotScale
	
	
	if GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE):
		print("Before: GVars.sigilData.costRot = ", GVars.sigilData.costRot)
		GVars.sigilData.costRot *= (indexFromAcquiredSigils + 1)
		print("After: GVars.sigilData.costRot = ", GVars.sigilData.costRot)
	
	# The size is used to keep track of what sigil to get from purchaseOrder.
	var addedSigil = sigilPurchaseOrder.purchaseOrder[indexFromAcquiredSigils]
	if indexFromAcquiredSigils < sigilPurchaseOrder.purchaseOrder.size():
		GVars.sigilData.acquiredSigils.append(addedSigil)
		sigilLabel.text = sigilText[addedSigil.sigilBuffIndex]
	else:
		sigilLabel.text = "Use it well!"
	buyButton.text = "Thx"
	sigilDisplay.frame = addedSigil.sigilBuffIndex
	sigilDisplay.show()
	failbought = true


func reset():
	const hellSigil : Sigil = preload("res://Resources/Sigil/HellSigil.tres")
	if hellSigil in GVars.sigilData.acquiredSigils:
		sigilLabel.text = "We're out lmao."
		buyButton.hide()
	elif not GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) :
		sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n" + str(GVars.getScientific(GVars.sigilData.costSpin)) + " momentum\n" + str(GVars.getScientific(GVars.sigilData.costRot)) + " rotations"
		if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
			sigilLabel.text += "\n" + str(GVars.sandCost) + " sand"
		buyButton.text = "Buy"
		failbought = false
	else:
		var numberOfAcquiredSigils : int = GVars.sigilData.acquiredSigils.size()
		sigilLabel.text = "Here for a sigil?\nIt\'ll cost ya:\n"
		if numberOfAcquiredSigils == 0:
			sigilLabel.text += "1000 momentum"
		elif numberOfAcquiredSigils == 1:
			sigilLabel.text += "20 rust"
		elif numberOfAcquiredSigils == 2:
			if not GVars.altSigilSand:
				sigilLabel.text += "5 mush levels\nYou\'ll need 6."
			else:
				sigilLabel.text += "5 sand dollars"
		elif numberOfAcquiredSigils == 3:
			sigilLabel.text += "4 size\nYou\'ll need 5."
		elif numberOfAcquiredSigils == 4:
			sigilLabel.text += "6 identity\nYou\'ll need 7"
		elif numberOfAcquiredSigils == 5:
			altprice = 100
			sigilLabel.text = "Here for a sigil?\nFully charge the kbity machine and I\'ll give it to you"
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
