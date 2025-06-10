extends Control


#@ Signals
signal rustbotSelectionPressed


#@ Public Variables
var sigilPurchaseOrder = GVars.currentSigilOrder


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


# Display sigils if acquired.
func displaySigils() -> void:
	var index : int = 0
	for sigil in GVars.sigilData.acquiredSigils:
		smSigils[index].setSigil(sigil)
		smSigils[index].show()
		print(sigil.sigilName)
		smSigils[index].modulate = Color.WHITE
		if sigil == GVars.sigilData.currentAugmentedSigil:
			smSigils[index].modulate = Color.AQUAMARINE
		index += 1


# Emits the sigiL_button_pressed signal with the correct parameters depending on which sigil button was pressed.
func _emitSignalOnSigilButtonPressed(sigil: Sigil) -> void:
	GVars.sigilData.currentAugmentedSigil = sigil
	displaySigils()
	emit_signal("rustbotSelectionPressed")
