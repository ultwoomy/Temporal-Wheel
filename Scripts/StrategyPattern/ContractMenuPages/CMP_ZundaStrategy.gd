extends CMP_Strategy
class_name CMP_ZundaStrategy


#@ Constants
const CONTRACT_NAME : String = "Zunda of the Night"
const CONTRACT_DESCRIPTION : String = "
	Zunda is hungry!
	Meet her growing list of demands
	Unlocks Zunda of the Night
	as an alternative to emptiness
"
const UPGRADE_DESCRIPTION : String = "
	Increase base momentum
	Based on momentum
	Cost: {cost}
	Current Upgrade: log(10 - {currently})
"
const CONTRACT_SIGIL_SPRITE : CompressedTexture2D = preload("res://Sprites/Sigils/sigil11.png")
const CONTRACT_BACKGROUND_COLOR : Color = Color8(0, 0, 27)


#@ Virtual Methods
# L.B: If making a new contract, probably don't modify this function.
func _showPage() -> void:
	_contractName = CONTRACT_NAME
	_assignContractDescription()
	_contractSigilSprite = CONTRACT_SIGIL_SPRITE
	_contractBackgroundColor = CONTRACT_BACKGROUND_COLOR
	super._showPage()


func _purchaseUpgrade() -> void:
	if(GVars.soulsData.spinBaseBuffCost <= GVars.soulsData.souls):
		GVars.soulsData.spinBaseBuff += 1
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls -= GVars.soulsData.spinBaseBuffCost
		GVars.soulsData.spinBaseBuffCost += GVars.soulsData.spinBaseBuffScaling
		# Update text.
		_assignContractDescription()
		_assignText()


func _getChallenge() -> ChallengeData:
	return GVars.CHALLENGE_STARVED


func _isContractCompleted() -> bool:
	return GVars.soulsData.spinBaseBuffEnabled


func _isUpgradeMaxed() -> bool:
	return GVars.soulsData.spinBaseBuff >= 7


#@ Private Methods
func _assignContractDescription() -> void:
	if _isContractCompleted():
		var upgradeDescription : String = UPGRADE_DESCRIPTION.format({"cost" : str(GVars.soulsData.doubleRotChanceCost), "currently" : str(GVars.soulsData.doubleRotChance)})
		_contractDescription = upgradeDescription
	else:
		_contractDescription = CONTRACT_DESCRIPTION
