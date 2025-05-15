extends Resource
class_name SigilPurchaseOrder


var packsmithSigil : Sigil = load("res://Resources/Sigil/PacksmithSigil.tres")
var candleSigil : Sigil = load("res://Resources/Sigil/CandleSigil.tres")
var ascSigil : Sigil = load("res://Resources/Sigil/AscensionSigil.tres")
var emptinessSigil : Sigil = load("res://Resources/Sigil/EmptinessSigil.tres")
var ritualSigil : Sigil = load("res://Resources/Sigil/RitualSigil.tres")
var hellSigil : Sigil = load("res://Resources/Sigil/HellSigil.tres")

var sandSigil : Sigil = load("res://Resources/Sigil/SandDollar.tres")
var twinsSigil : Sigil = load("res://Resources/Sigil/TwinsSigil.tres")
var undercitySigil : Sigil = load("res://Resources/Sigil/UndercitySigil.tres")
var zundaNightSigil : Sigil = load("res://Resources/Sigil/ZundaNightSigil.tres")


#@ Export Variables
@export var purchaseOrder : Array[Sigil]


func _init():
	purchaseOrder.append(packsmithSigil)
	purchaseOrder.append(candleSigil)
	purchaseOrder.append(ascSigil)
	purchaseOrder.append(emptinessSigil)
	purchaseOrder.append(ritualSigil)
	purchaseOrder.append(hellSigil)


func swap(index, sigil):
	if purchaseOrder.size() > index:
		purchaseOrder[index] = sigil
