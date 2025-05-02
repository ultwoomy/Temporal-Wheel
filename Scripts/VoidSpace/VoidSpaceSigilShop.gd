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
	reset()
	
	sandLabel.visible = GVars.hasChallengeActive(GVars.CHALLENGE_SANDY)
	
	# Connect signals.
	buyButton.pressed.connect(self._onButtonPressed)


func _process(delta: float) -> void:
	sandLabel.text = "Sand\namount:\n" + str(GVars.sand)


#@ Public Methods
func checkCurrentSigil():
	var indexFromAcquiredSigils : int = GVars.sigilData.acquiredSigils.size()
	GVars.sigilData.costSpin = pow(GVars.sigilData.costSpin, GVars.sigilData.costSpinScale)
	GVars.sigilData.costRot *= GVars.sigilData.costRotScale
	
	
	if GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE):
		print("Before: GVars.sigilData.costRot = ", GVars.sigilData.costRot)
		GVars.sigilData.costRot *= (indexFromAcquiredSigils + 1)
		print("After: GVars.sigilData.costRot = ", GVars.sigilData.costRot)
	
	# The size is used to keep track of what sigil to get from purchaseOrder.
	var addedSigil : Sigil = sigilPurchaseOrder.purchaseOrder[indexFromAcquiredSigils]
	if indexFromAcquiredSigils < sigilPurchaseOrder.purchaseOrder.size():
		GVars.sigilData.acquiredSigils.append(addedSigil)
		sigilLabel.text = sigilText[addedSigil.sigilBuffIndex]
	else:
		sigilLabel.text = "Use it well!"
	buyButton.text = "Thx"
	sigilDisplay.frame = addedSigil.sigilBuffIndex
	sigilDisplay.show()
	failbought = true


func reset() -> void:
	# Check to see if the shop is out of Sigils.
	# TODO: Have condition be modular.
	if hellSigil in GVars.sigilData.acquiredSigils:
		sigilLabel.text = "We're out lmao."
		buyButton.hide()
		return
	
	sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n"
	# If NOT in the Bittersweet challenge.
	if not GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) :
		sigilLabel.text += str(GVars.getScientific(GVars.sigilData.costSpin)) + " momentum\n"
		sigilLabel.text += str(GVars.getScientific(GVars.sigilData.costRot)) + " rotations"
		if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
			sigilLabel.text += "\n" + str(GVars.sandCost) + " sand"
	# If in the Bittersweet challenge.
	else:
		var numberOfAcquiredSigils : int = GVars.sigilData.acquiredSigils.size()
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
	
	# Reset to have new sigil available
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


#@ Private Methods
func _onButtonPressed():
	GVars._dialouge(sigilLabel, 0, 0.02)
	
	# If Player was unable to afford the sigil...
	if failbought:
		reset()
		return
	
	# Get price of sigil.
	var _sigilPrice : ShopPrice = ShopPrice.new()
	if GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET):  # Alternate prices for the sigil price if in BITTERSWEET challenge.
		_getSigilPrice(_sigilPrice, "BITTERSWEET")
	else:
		if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
			_getSigilPrice(_sigilPrice, "SANDY")
		_getSigilPrice(_sigilPrice)
	
	print("_sigilPrice.spinCost = " + str(_sigilPrice.spinCost) + "\n" +
		"_sigilPrice.rustCost = " + str(_sigilPrice.rustCost) + "\n" +
		"_sigilPrice.rotationCost = " + str(_sigilPrice.rotationCost) + "\n" +
		"_sigilPrice.sandCost = " + str(_sigilPrice.sandCost) + "\n" +
		"_sigilPrice.ascensionSpinBuffCost = " + str(_sigilPrice.ascensionSpinBuffCost) + "\n" +
		"_sigilPrice.dollarCost = " + str(_sigilPrice.dollarCost) + "\n" +
		"_sigilPrice.kbityLevelCost = " + str(_sigilPrice.kbityLevelCost) + "\n" +
		"_sigilPrice.mushroomLevelCost = " + str(_sigilPrice.mushroomLevelCost) + "\n" +
		"_sigilPrice.wheelSizeCost = " + str(_sigilPrice.wheelSizeCost) + "\n"
	)
	# Pay for the sigil, if able.
	_payPrice(_sigilPrice)
	
	'
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
		elif GVars.altSigilSand and GVars.dollarData.dollarTotal >= 5:  # (!) Variable does not exist?!
			GVars.dollarTotal -= 5  # (!) Variable does not exist?!
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
	'


func _getSigilPrice(shopPrice : ShopPrice, specialConditions : String = "") -> void:
	match specialConditions:
		"BITTERSWEET":
			if not acquiredPacksmithSigil:
				shopPrice.spinCost = 1000
			if not acquiredCandleSigil:
				shopPrice.rustCost = 20
			if not acquiredAscensionSigil:
				shopPrice.mushroomLevelCost = 5
				# TODO
				'
				elif GVars.altSigilSand and GVars.dollarData.dollarTotal >= 5:  # (!) Variable does not exist?!
				GVars.dollarTotal -= 5  # (!) Variable does not exist?!
				checkCurrentSigil()
				'
			if not acquiredEmptinessSigil:
				shopPrice.wheelSizeCost = 4
			if not acquiredRitualSigil:
				shopPrice.ascensionSpinBuffCost = 6
			if not acquiredHellSigil:
				# TODO
				pass
			else:
				# TODO: What to do when no sigil?!
				return
		"SANDY":
			shopPrice.sandCost = GVars.sandCost
			# GVars.sandCost += GVars.sandScaling
		_:
			shopPrice.spinCost = pow(GVars.sigilData.costSpin, GVars.sigilData.costSpinScale)
			shopPrice.rotationCost = GVars.sigilData.costRotScale


func _payPrice(shopPrice : ShopPrice) -> void:
	# Make sure you can actually pay for the sigil.
	var _failConditions : Array[bool] = [
		shopPrice.spinCost > GVars.spinData.spin,
		shopPrice.rotationCost > GVars.spinData.rotations,
		shopPrice.sandCost > GVars.sandCost,
		shopPrice.rustCost > GVars.rustData.rust,
		shopPrice.mushroomLevelCost > GVars.mushroomData.level,
		shopPrice.dollarCost > 5,  # TODO: THE VARIABLE:  GVars.dollarData.dollarTotal  DOES NOT EXIST!
		shopPrice.wheelSizeCost > GVars.spinData.size,  # TODO: Have a const instead
		shopPrice.ascensionSpinBuffCost > GVars.Aspinbuff,  # TODO: Have a const instead
		shopPrice.kbityLevelCost > GVars.kbityData.kbityLevel  # WIP
	]
	## TODO: MORE TESTING
	print("shopPrice.spinCost = ", shopPrice.spinCost, " > GVars.spinData.spin = ", GVars.spinData.spin)
	for boolean in _failConditions:
		if boolean:
			checkStupid()
			return
	# Pay for sigil.
	GVars.spinData.spin -= shopPrice.spinCost
	GVars.spinData.rotations -= shopPrice.rotationCost
	GVars.sand -= shopPrice.sandCost
	# TODO: GVars.sandCost += GVars.sandScaling
	GVars.rustData.rust -= shopPrice.rustCost
	GVars.mushroomData.level -= shopPrice.mushroomLevelCost
	# TODO: ERROR - This variable doesn't exist!
	#GVars.dollarTotal -= shopPrice.dollarCost
	GVars.spinData.size -= shopPrice.wheelSizeCost
	GVars.Aspinbuff -= shopPrice.ascensionSpinBuffCost
	shopPrice.kbityLevelCost  # TODO: Code was left unfinished, so finish this when kbity is done!
	checkCurrentSigil()


#@ Subclasses
class ShopPrice:
	var spinCost : float = 0.0
	var rotationCost : float = 0.0
	var sandCost : float = 0.0 # (!) GVars already has a variable for this. Should this replace it?
	var rustCost : float = 0.0
	var mushroomLevelCost : int = 0
	var dollarCost : int = 0 # (!) GVars.dollarTotal does not even exist
	var wheelSizeCost : float = 0.0 # (?) Apparently GVars.spinData.size is a FLOAT instead of an INT.
	var ascensionSpinBuffCost : float = 0.0
	var kbityLevelCost : int = 0
