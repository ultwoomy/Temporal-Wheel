extends Control


#@ Signals
signal sigilSwapped


#@ Public Variables
var sigilPurchaseOrder : SigilPurchaseOrder = load("res://Resources/Sigil Purchase Order/NextSigilPurchaseOrder.tres")
var packsmithSigil : Sigil = load("res://Resources/Sigil/PacksmithSigil.tres")
var candleSigil : Sigil = load("res://Resources/Sigil/CandleSigil.tres")
var emptinessSigil : Sigil = load("res://Resources/Sigil/EmptinessSigil.tres")
var hellSigil : Sigil = load("res://Resources/Sigil/HellSigil.tres")
var ritualSigil : Sigil = load("res://Resources/Sigil/RitualSigil.tres")
var sandSigil : Sigil = load("res://Resources/Sigil/SandDollarSigil.tres")
var twinsSigil : Sigil = load("res://Resources/Sigil/TwinsSigil.tres")
var undercitySigil : Sigil = load("res://Resources/Sigil/UndercitySigil.tres")
var zundaNightSigil : Sigil = load("res://Resources/Sigil/ZundaNightSigil.tres")


#@ Onready Variables
@onready var smSigil01 : SelectionMenuSigil = $Sigil01
@onready var smSigil02 : SelectionMenuSigil = $Sigil02
@onready var smSigil03 : SelectionMenuSigil = $Sigil03
@onready var smSigil04 : SelectionMenuSigil = $Sigil04
@onready var smSigil05 : SelectionMenuSigil = $Sigil05
@onready var smSigil06 : SelectionMenuSigil = $Sigil06
@onready var smSigils : Array[SelectionMenuSigil] = [smSigil01, smSigil02, smSigil03, smSigil04, smSigil05, smSigil06]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide sigils.
	for smSigil in smSigils:
		smSigil.hide()
	
	setUpSigils()
	displaySigils()


#@ Public Methods
func setUpSigils() -> void:
	var index : int = 0
	for selectionMenuSigil in smSigils:
		# Assign sigil resource to the sigil node.
		selectionMenuSigil.setSigil(sigilPurchaseOrder.purchaseOrder[index])
		
		# Check to see if the button is not already connected.
		if not selectionMenuSigil.button.pressed.is_connected(_emitSignalOnSigilButtonPressed):
			# Passes the assigned sigil into the function using the sigil.sigil variable.
			# The sigil.sigil is an export variable that you assign to sigil instances.
			selectionMenuSigil.button.pressed.connect(_emitSignalOnSigilButtonPressed.bind(selectionMenuSigil.sigil))
		index += 1


# Display sigils in current path
func displaySigils() -> void:
	var index : int = 0
	for sigil in sigilPurchaseOrder.purchaseOrder:
		smSigils[index].setSigil(sigil)
		smSigils[index].show()


# Emits the sigiL_button_pressed signal with the correct parameters depending on which sigil button was pressed.
func _emitSignalOnSigilButtonPressed(sigil: Sigil) -> void:
	if sigil.sigilName == "packsmith":
		sigilPurchaseOrder.purchaseOrder[0] = twinsSigil
	if sigil.sigilName == "candle":
		sigilPurchaseOrder.purchaseOrder[0] = sandSigil
	if sigil.sigilName == "emptiness":
		sigilPurchaseOrder.purchaseOrder[0] = undercitySigil
	if sigil.sigilName == "ritual":
		sigilPurchaseOrder.purchaseOrder[0] = zundaNightSigil
	if sigil.sigilName == "sanddollar":
		sigilPurchaseOrder.purchaseOrder[0] = candleSigil
	if sigil.sigilName == "twins":
		sigilPurchaseOrder.purchaseOrder[0] = packsmithSigil
	if sigil.sigilName == "undercity":
		sigilPurchaseOrder.purchaseOrder[0] = emptinessSigil
	if sigil.sigilName == "zundanight":
		sigilPurchaseOrder.purchaseOrder[0] = ritualSigil
	displaySigils()
	emit_signal("sigilSwapped")
