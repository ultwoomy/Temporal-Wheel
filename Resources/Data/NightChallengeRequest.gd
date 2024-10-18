extends Node
class_name Request

enum type{
	MOMENTUM,
	ROTATIONS,
	CHEESE
}

@export var currentType : type
@export var amount : float
@export var secondaryTypeEnabled : bool
@export var secondaryType : type
@export var secondaryAmount : float
@export var impatienceMult : float
@export var finished : bool

func _init():
	currentType = type.MOMENTUM
	amount = 0
	secondaryTypeEnabled = false
	secondaryType = type.MOMENTUM
	secondaryAmount = 0
	impatienceMult = 1
	finished = false
	
func initializePrimary(x : String, y : float):
	setType(x, true)
	amount = y
	
func initializeSecondary(x : String, y : float):
	setType(x, false)
	secondaryAmount = y
	secondaryTypeEnabled = true

func checkPassing():
	if currentType == type.MOMENTUM:
		if GVars.spinData.spin >= amount:
			if checkSecondary():
				GVars.spinData.spin -= amount
				return true
		else:
			return false
	if currentType == type.ROTATIONS:
		if GVars.spinData.rotations >= amount:
			if checkSecondary():
				GVars.spinData.rotations -= amount
				return true
		else:
			return false
	if currentType == type.CHEESE:
		return checkSecondary()
	return false
	
func toString() -> String:
	var temp = ""
	var temp2 = ""
	temp = getPrimaryType()
	temp2 = getSecondaryType()
	return temp + " " + str(amount) + " " + str(secondaryTypeEnabled) + " " + temp2 + " " + str(secondaryAmount)

func getPrimaryType() -> String:
	if currentType == type.MOMENTUM:
		return "momentum"
	elif currentType == type.ROTATIONS:
		return "rotations"
	elif currentType == type.CHEESE:
		return "cheese"
	return "error"
	
func getSecondaryType() -> String:
	if secondaryType == type.MOMENTUM:
		return "momentum"
	elif secondaryType == type.ROTATIONS:
		return "rotations"
	elif secondaryType == type.CHEESE:
		return "cheese"
	return "error"

func upImpatience():
	impatienceMult += 0.001
	amount *= impatienceMult
	secondaryAmount *= impatienceMult
	
#private functions
func setType(x : String, primary : bool):
	if primary:
		if x == "momentum":
			currentType = type.MOMENTUM
		elif x == "rotations":
			currentType = type.ROTATIONS
		elif x == "cheese":
			currentType = type.CHEESE
	else:
		if x == "momentum":
			secondaryType = type.MOMENTUM
		elif x == "rotations":
			secondaryType = type.ROTATIONS
		elif x == "cheese":
			secondaryType = type.CHEESE
			

func checkSecondary():
	if secondaryTypeEnabled:
		if secondaryType == type.MOMENTUM:
			if GVars.spinData.spin >= secondaryAmount:
				GVars.spinData.spin -= secondaryAmount
				return true
			else:
				return false
		if secondaryType == type.ROTATIONS:
			if GVars.spinData.rotations >= secondaryAmount:
				GVars.spinData.rotations -= secondaryAmount
				return true
			else:
				return false
		if secondaryType == type.CHEESE:
			return GVars.backpackData.cheese
	else:
		return true

