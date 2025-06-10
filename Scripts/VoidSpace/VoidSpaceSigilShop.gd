extends Control
class_name VoidSpaceSigilShop


#@ Constants
const SIGIL_PACKSMITH 	: Sigil = preload("res://Resources/Sigil/PacksmithSigil.tres")
const SIGIL_CANDLE 		: Sigil = preload("res://Resources/Sigil/CandleSigil.tres")
const SIGIL_ASCENSION 	: Sigil = preload("res://Resources/Sigil/AscensionSigil.tres")
const SIGIL_EMPTINESS 	: Sigil = preload("res://Resources/Sigil/EmptinessSigil.tres")
const SIGIL_RITUAL 		: Sigil = preload("res://Resources/Sigil/RitualSigil.tres")
const SIGIL_HELL 		: Sigil = preload("res://Resources/Sigil/HellSigil.tres")
const SIGIL_SAND      	: Sigil = preload("res://Resources/Sigil/SandSigil.tres")
const SIGIL_TWINS  	  	: Sigil = preload("res://Resources/Sigil/TwinsSigil.tres")
const SIGIL_UNDERCITY 	: Sigil = preload("res://Resources/Sigil/UndercitySigil.tres")
const SIGIL_ZUNDA_NIGHT	: Sigil = preload("res://Resources/Sigil/ZundaNightSigil.tres")

const FAILED_PURCHASE_DIALOGUE_FILE_PATH : String = "res://JSON/Dialogue/VoidSpaceStop/VoidSpaceSigilShop.json"
const FAILED_PURCHASE_DIALOGUE_KEY : String = "failedPurchase"  # The key in the FAILED_PURCHASE_DIALOGUE_FILE_PATH JSON file to access the data.


#@ Export Variables


#@ Public Variables
var fmat = preload("res://Scripts/FormatNo.gd")
var failbought : bool
var altprice = 0

var sigilPurchaseOrder : SigilPurchaseOrder = GVars.currentSigilOrder
var sigilForSale : Sigil
var sigilMomentumPrice : float = GVars.sigilData.costMomentum
var sigilRotationPrice : float = GVars.sigilData.costRot
var sigilAdditionalPriceAsString : String  # Keep track of the additional price of a sigil so it can be displayed later.

# Dialogue related variables.
var dialogueHandler : DialogueHandler = DialogueHandler.new()
var dialogueCounter : int = 0


#@ Onready Variables
@onready var sigilLabel : Label = $SigilLabel
@onready var buyButton : Button = $BuyButton
@onready var button : Button = $BuyButton
@onready var sigilDisplay : AnimatedSprite2D = $SigilDisplay
@onready var sandLabel : Label = $SandLabel
@onready var fabulousChallengeComponent : FabulousCComp = $FabulousCComponent  # Optional (it's not)
@onready var currencyUI : VoidSpaceCurrencyUI = $CurrencyUI


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Visuals.
	sigilDisplay.hide()
	reset()
	sandLabel.visible = GVars.hasChallengeActive(GVars.CHALLENGE_SANDY)
	
	# Assign important variables.
	dialogueHandler.dialogueFilePath = FAILED_PURCHASE_DIALOGUE_FILE_PATH
	
	# Connect signals.
	buyButton.pressed.connect(self._onButtonPressed)


func _process(_delta: float) -> void:
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
	
	if not sigilForSale == SIGIL_HELL:  # (!) If buying the hell sigil, the text becomes different. Check _getSigilPrice().
		sigilLabel.text = "Here for a sigil?\nIt'll cost ya:\n"
	else:
		sigilLabel.text = ""
	# If NOT in the Bittersweet challenge.
	if not GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET) :
		sigilLabel.text += str(GVars.getScientific(sigilMomentumPrice)) + " momentum\n"
		sigilLabel.text += str(GVars.getScientific(sigilRotationPrice)) + " rotations"
		if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
			sigilLabel.text += "\n" + str(GVars.sandCost) + " sand"
	
	# If in the Bittersweet challenge.
	else:
		sigilLabel.text += sigilAdditionalPriceAsString
	
	# Reset to have new sigil available
	buyButton.text = "Buy"
	failbought = false


#@ Private Methods
func _onButtonPressed():
	GVars._dialouge(sigilLabel, 0, 0.02)
	
	# Get price of sigil.
	var _sigilPrice : ShopPrice = ShopPrice.new()
	if GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET):  # Alternate prices for the sigil price if in BITTERSWEET challenge.
		_getSigilPrice(_sigilPrice, "BITTERSWEET")
	else:
		if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
			_getSigilPrice(_sigilPrice, "SANDY")
		_getSigilPrice(_sigilPrice)
	
	# If Player was unable to afford the sigil...
	if failbought:
		reset()
		return
	
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
		currencyUI.displayCurrency()
		_raiseSigilPrice()
		_acquireSigil()
	else:
		_notifyFailedShopPurchase()


# Given a ShopPrice subclass object, modify it to get the price for the sigil. Subclasses are passed by reference.
func _getSigilPrice(shopPrice : ShopPrice, specialConditions : String = "") -> void:
	match specialConditions:
		"BITTERSWEET":
			if not GVars.sigilData.acquiredSigils.has(SIGIL_PACKSMITH):  # Player should have 0 owned sigils.
				shopPrice.spinCost = 1000
				sigilAdditionalPriceAsString = str(shopPrice.spinCost) + " momentum"
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_CANDLE):
				shopPrice.rustCost = 20
				sigilAdditionalPriceAsString = str(shopPrice.rustCost) + " rust"
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_ASCENSION):
				if GVars.altSigilSand:
					sigilAdditionalPriceAsString = "5 sand dollars"
					# TODO:
					# GVars.dollarTotal -= 5  # (!) Variable does not exist?!
				else:
					shopPrice.mushroomLevelCost = 5
					sigilAdditionalPriceAsString = str(shopPrice.mushroomLevelCost) + " mush levels\nYou\'ll need " + str(shopPrice.mushroomLevelCost + 1) + "."
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_EMPTINESS):
				shopPrice.wheelSizeCost = 4
				sigilAdditionalPriceAsString = str(shopPrice.wheelSizeCost) + " size\nYou\'ll need " + str(shopPrice.wheelSizeCost + 1) + "."
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_RITUAL):
				shopPrice.ascensionSpinBuffCost = 6
				sigilAdditionalPriceAsString = str(shopPrice.ascensionSpinBuffCost) + " identity\nYou\'ll need " + str(shopPrice.ascensionSpinBuffCost + 1) + "."
			elif not GVars.sigilData.acquiredSigils.has(SIGIL_HELL):
				# TODO: L.B: There was no price assigned for hell sigil for the BITTERSWEET challenge!
				# No idea what altprice is! Need to make it a variable in the subclass!
				# (!!!) As it stands, you don't pay anything at all to get this sigil!
				altprice = 100
				sigilAdditionalPriceAsString = "Here for a sigil?\nFully charge the kbity machine and I\'ll give it to you"
			else:
				# TODO: What to do when no sigil?!
				return
		"SANDY":
			shopPrice.sandCost = GVars.sandCost
			# GVars.sandCost += GVars.sandScaling
		_:
			shopPrice.spinCost = sigilMomentumPrice
			shopPrice.rotationCost = sigilRotationPrice


# Make sure the Player can actually pay for the sigil whose price is determined by the ShopPrice subclass.
func _canAfford(shopPrice : ShopPrice) -> bool:
	var _failConditions : Array[bool] = [
		shopPrice.spinCost > GVars.spinData.momentum,
		shopPrice.rotationCost > GVars.spinData.rotations,
		shopPrice.sandCost > GVars.sand,
		shopPrice.rustCost > GVars.rustData.rust,
		shopPrice.mushroomLevelCost >= GVars.mushroomData.level,  # (!) The Player can only pay if their level is HIGHER.
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
	GVars.spinData.momentum -= shopPrice.spinCost
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
	sigilMomentumPrice **= GVars.sigilData.costMomentumScale  # To the power of
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
	dialogueCounter = 0


func _notifyFailedShopPurchase():
	var failedPurchaseDialogueData : Array[Dictionary] = dialogueHandler.getDialogueData(FAILED_PURCHASE_DIALOGUE_KEY)
	if dialogueCounter < failedPurchaseDialogueData.size():
		sigilLabel.text = dialogueHandler.getFromSpecialKey(failedPurchaseDialogueData[dialogueCounter], DialogueHandler.SpecialKeys.TEXT)
		dialogueCounter += 1
	else:
		sigilLabel.text = "I like secrets!"
	buyButton.text = "Oh"
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
