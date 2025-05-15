extends Control
class_name VoidSpaceSigilShop


#@ Constants
const SIGIL_PACKSMITH 	: Sigil = preload("res://Resources/Sigil/PacksmithSigil.tres")
const SIGIL_CANDLE 		: Sigil = preload("res://Resources/Sigil/CandleSigil.tres")
const SIGIL_ASCENSION 	: Sigil = preload("res://Resources/Sigil/AscensionSigil.tres")
const SIGIL_EMPTINESS 	: Sigil = preload("res://Resources/Sigil/EmptinessSigil.tres")
const SIGIL_RITUAL 		: Sigil = preload("res://Resources/Sigil/RitualSigil.tres")
const SIGIL_HELL 		: Sigil = preload("res://Resources/Sigil/HellSigil.tres")
const SIGIL_SAND      	: Sigil = preload("res://Resources/Sigil/SandDollar.tres")
const SIGIL_TWINS  	  	: Sigil = preload("res://Resources/Sigil/TwinsSigil.tres")
const SIGIL_UNDERCITY 	: Sigil = preload("res://Resources/Sigil/UndercitySigil.tres")
const SIGIL_ZUNDA_NIGHT	: Sigil = preload("res://Resources/Sigil/ZundaNightSigil.tres")


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")
var failbought : bool
var stupids : int = 0
var altprice = 0

var sigilPurchaseOrder : SigilPurchaseOrder = GVars.currentSigilOrder
var sigilForSale : Sigil
var sigilSpinPrice : float = GVars.sigilData.costSpin
var sigilRotationPrice : float = GVars.sigilData.costRot


#@ Onready Variables
@onready var sigilLabel : Label = $SigilLabel
@onready var buyButton : Button = $BuyButton
@onready var button : Button = $BuyButton
@onready var sigilDisplay : AnimatedSprite2D = $SigilDisplay
@onready var sandLabel : Label = $SandLabel
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent  # Optional (it's not)


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	sigilDisplay.hide()
	reset()
	
	sandLabel.visible = GVars.hasChallengeActive(GVars.CHALLENGE_SANDY)
	
	# Connect signals.
	buyButton.pressed.connect(self._onButtonPressed)


func _process(delta: float) -> void:
	# TODO: Have sand amount change text from a signal instead if possible.
	sandLabel.text = "Sand\namount:\n" + str(GVars.sand)


#@ Public Methods
func reset() -> void:
	# Check to see if the shop is out of Sigils.
	# TODO: Have condition be modular.
	if GVars.sigilData.acquiredSigils.has(SIGIL_HELL):
		sigilLabel.text = "We're out lmao."
		buyButton.hide()
		return
	
	# Keeps track of what sigils are left to buy in the sigilPurchaseOrder.
	var sigilPurchaseOrderIndex : int = GVars.sigilData.acquiredSigils.size()  # To get the sigil from the SigilPurchaseOrder, you need an index.
	if sigilPurchaseOrderIndex < GVars.currentSigilOrder.purchaseOrder.size():  # Make sure that index is in bounds.
		sigilForSale = GVars.currentSigilOrder.purchaseOrder[sigilPurchaseOrderIndex]
	
	sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n"
	# If NOT in the Bittersweet challenge.
	if not GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) :
		sigilLabel.text += str(GVars.getScientific(sigilSpinPrice)) + " momentum\n"
		sigilLabel.text += str(GVars.getScientific(sigilRotationPrice)) + " rotations"
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
	if _canAfford(_sigilPrice):
		_payPrice(_sigilPrice)
		_raiseSigilPrice()
		_acquireSigil()
	else:
		checkStupid()


# Given a ShopPrice subclass object, modify it to get the price for the sigil. Subclasses are passed by reference.
func _getSigilPrice(shopPrice : ShopPrice, specialConditions : String = "") -> void:
	match specialConditions:
		"BITTERSWEET":
			if not GVars.sigilData.acquiredSigils.has(SIGIL_PACKSMITH):
				shopPrice.spinCost = 1000
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_CANDLE):
				shopPrice.rustCost = 20
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_ASCENSION):
				shopPrice.mushroomLevelCost = 5
				# TODO
				'
				elif GVars.altSigilSand and GVars.dollarData.dollarTotal >= 5:  # (!) Variable does not exist?!
				GVars.dollarTotal -= 5  # (!) Variable does not exist?!
				checkCurrentSigil()
				'
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_EMPTINESS):
				shopPrice.wheelSizeCost = 4
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_RITUAL):
				shopPrice.ascensionSpinBuffCost = 6
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_HELL):
				# TODO: L.B: There was no price assigned for hell sigil for the BITTERSWEET challenge!
				pass
			else:
				# TODO: What to do when no sigil?!
				return
		"SANDY":
			shopPrice.sandCost = GVars.sandCost
			# GVars.sandCost += GVars.sandScaling
		_:
			shopPrice.spinCost = sigilSpinPrice
			shopPrice.rotationCost = sigilRotationPrice


# Make sure the Player can actually pay for the sigil whose price is determined by the ShopPrice subclass.
func _canAfford(shopPrice : ShopPrice) -> bool:
	var _failConditions : Array[bool] = [
		shopPrice.spinCost > GVars.spinData.spin,
		shopPrice.rotationCost > GVars.spinData.rotations,
		shopPrice.sandCost > GVars.sand,
		shopPrice.rustCost > GVars.rustData.rust,
		shopPrice.mushroomLevelCost > GVars.mushroomData.level,
		shopPrice.dollarCost > 5,  # TODO: THE VARIABLE:  GVars.dollarData.dollarTotal  DOES NOT EXIST!
		shopPrice.wheelSizeCost > GVars.spinData.size,
		shopPrice.ascensionSpinBuffCost > GVars.Aspinbuff,
		shopPrice.kbityLevelCost > GVars.kbityData.kbityLevel  # TODO: WIP
	]
	for boolean in _failConditions:
		if boolean:  # If any of the fail conditions is TRUE, return FALSE.
			return false
	return true


# Pay for a sigil given by the ShopPrice subclass.
func _payPrice(shopPrice : ShopPrice) -> void:
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


# Increase the non-alternative price of the next sigil.
func _raiseSigilPrice() -> void:
	var indexFromAcquiredSigils : int = GVars.sigilData.acquiredSigils.size()
	sigilSpinPrice **= GVars.sigilData.costSpinScale  # To the power of
	sigilRotationPrice *= GVars.sigilData.costRotScale
	
	# Further increase rotation price if in the BRAVE challenge.
	if GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE):
		sigilRotationPrice *= indexFromAcquiredSigils + 1


# Have the Player receive the current sigil being sold.
func _acquireSigil() -> void:
	# See if there is a sigil for sale.
	if not sigilForSale:
		return
	
	# Add the sigil to Player.
	GVars.sigilData.acquiredSigils.append(sigilForSale)
	
	# Display and describe the sigil.
	sigilLabel.text = sigilForSale.sigilShopDescription
	sigilDisplay.frame = sigilForSale.sigilBuffIndex
	sigilDisplay.show()
	buyButton.text = "Thx"
	
	# Reset the shop.
	sigilForSale = null
	failbought = true


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
