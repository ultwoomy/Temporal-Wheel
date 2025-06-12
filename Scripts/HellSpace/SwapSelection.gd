extends Control
@export var desc : Label

#@ Signals
signal sigilSwapped


#@ Public Variables
var sigilPurchaseOrder : SigilPurchaseOrder = GVars.nextSigilOrder


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
		
		# Check to see if the button is not already connected. Disconnects and reconnects if it is.
		if selectionMenuSigil.button.pressed.is_connected(_emitSignalOnSigilButtonPressed):
			selectionMenuSigil.button.pressed.disconnect(_emitSignalOnSigilButtonPressed.bind(selectionMenuSigil.sigil))
		selectionMenuSigil.button.pressed.connect(_emitSignalOnSigilButtonPressed.bind(selectionMenuSigil.sigil))
		index += 1


# Display sigils in current path
func displaySigils() -> void:
	var index : int = 0
	for sigil in sigilPurchaseOrder.purchaseOrder:
		smSigils[index].setSigil(sigil)
		smSigils[index].show()
		index += 1


# Emits the sigiL_button_pressed signal with the correct parameters depending on which sigil button was pressed.
func _emitSignalOnSigilButtonPressed(sigil: Sigil) -> void:
	if sigil.sigilName == "packsmith" and GVars.soulsData.voidRustChanceEnabled:
		sigilPurchaseOrder.swap(0, GVars.SIGIL_TWIN)
		sigil = GVars.SIGIL_TWIN
	elif sigil.sigilName == "candle" and GVars.soulsData.doubleShroomChanceEnabled:
		sigilPurchaseOrder.swap(1, GVars.SIGIL_SAND)
		sigil = GVars.SIGIL_SAND
	elif sigil.sigilName == "emptiness" and GVars.soulsData.doubleRotChanceEnabled:
		sigilPurchaseOrder.swap(3, GVars.SIGIL_UNDERCITY)
		sigil = GVars.SIGIL_UNDERCITY
	elif sigil.sigilName == "ritual" and GVars.soulsData.spinBaseBuffEnabled:
		sigilPurchaseOrder.swap(4, GVars.SIGIL_ZUNDANIGHT)
		sigil = GVars.SIGIL_ZUNDANIGHT
	elif sigil.sigilName == "sand":
		sigilPurchaseOrder.swap(1, GVars.SIGIL_CANDLE)
		sigil = GVars.SIGIL_CANDLE
	elif sigil.sigilName == "twins":
		sigilPurchaseOrder.swap(0, GVars.SIGIL_PACKSMITH)
		sigil = GVars.SIGIL_PACKSMITH
	elif sigil.sigilName == "undercity":
		sigilPurchaseOrder.swap(3, GVars.SIGIL_UNDERCITY)
		sigil = GVars.SIGIL_UNDERCITY
	elif sigil.sigilName == "zundanight":
		sigilPurchaseOrder.swap(4, GVars.SIGIL_RITUAL)
		sigil = GVars.SIGIL_RITUAL
	displaySigils()
	setUpSigils()
	setDesc(sigil)
	GVars.nextSigilOrder = sigilPurchaseOrder

func setDesc(sigil):
	if sigil.sigilName == "packsmith":
		desc.text = "Current Sigil In Slot: Packsmith\n\nGives access to rust upgrades, automators, and augment bonuses. Most runs should use this.
		\n\nIt lives in a little hole, augmenting things by wacking them with a tiny hammer. The first version of this game had a little animation, but it was changed since it didn't fit."
	elif sigil.sigilName == "candle":
		desc.text = "Current Sigil In Slot: Candle\n\nAllows you to grow mushrooms for buffs and resources. Use when trying to progress very far in a long run.\n\n
		Most creatures in this place have one somewhere, 1 is enough to light any space no matter the size."
	elif sigil.sigilName == "ascension":
		desc.text = "Current Sigil In Slot: Ascension\n\nResets some values in exchange for a momentum buff in your next run. Fly into the sea and come back anew.\n\n
		It's a reference to a song I like. The feeling it gives is haunting."
	elif sigil.sigilName == "ritual":
		desc.text = "Current Sigil In Slot: Ritual\n\nGives you other buffs in exchange for a portion of your spin speed. Each candle lit increases the price.\n\n
		Some candles are more useful than others, and the top candle is useless unless you need to do a certain challenge..."
	elif sigil.sigilName == "emptiness":
		desc.text = "Current Sigil In Slot: Emptiness\n\nAugmenting this will let you choose from a set of buffs on ascending. These are needed to progress the game. Doesn't do anything by itself.\n\nThis is also a song reference, faces expressing emotions that don't exist."
	elif sigil.sigilName == "hell":
		desc.text = "Current Sigil In Slot: Dinner Hell\n\nUnlocks Hell, and gives you access to the harder challenges. Though if you're seeing this, you've already
		beaten one.\n\nThis is also a song reference, blue everywhere."
	elif sigil.sigilName == "sand":
		desc.text = "Current Sigil In Slot: Sand Dollar\n\nComplete goals for sand dollars, with the option of spending them on a headstart on the start of a reset. Most
		powerful identity buffer in the game.\n\nNot a reference to anything, I just think they look neat."
	elif sigil.sigilName == "twins":
		desc.text = "Current Sigil In Slot: The Twins\n\nWhat they will do when I actually code them is a secret...\nThey were originally supposed to be joke characters in the first version of the game but I changed it."
	elif sigil.sigilName == "undercity":
		desc.text = "Current Sigil In Slot: Undercity\n\nThis one isn't finished, it will probably take the longest among the unfinished content since it's going to be a story focused sigil, and needs a lot of art."
	elif sigil.sigilName == "zundanight":
		desc.text = "Current Sigil In Slot: Zunda of The Night\n\nDoesn't do anything right now but will likely either make the game much harder or much easier\n\n
		This is a reference to a series of Zunda songs where she represents Yoru, man eating beast of the night. I thought it was really cool and smuggled her in."
