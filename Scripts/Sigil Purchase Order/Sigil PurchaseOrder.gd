extends Resource
class_name SigilPurchaseOrder


#@ Export Variables
@export var purchaseOrder : Array[Sigil]


func _init():
	purchaseOrder.append(GVars.SIGIL_PACKSMITH)
	purchaseOrder.append(GVars.SIGIL_CANDLE)
	purchaseOrder.append(GVars.SIGIL_ASCENSION)
	purchaseOrder.append(GVars.SIGIL_EMPTINESS)
	purchaseOrder.append(GVars.SIGIL_RITUAL)
	purchaseOrder.append(GVars.SIGIL_HELL)


func swap(index, sigil):
	if purchaseOrder.size() > index:
		purchaseOrder[index] = sigil
