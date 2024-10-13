extends CMP_Strategy
class_name CMP_SandStrategy


#@ Constants
const CONTRACT_NAME : String = "Sand Dollar"
const CONTRACT_CHALLENGE : ChallengeData = GVars.CHALLENGE_SANDY
const CONTRACT_DESCRIPTION : String = "
	The more you have
	The less you get
	Unlocks the sand dollar as an
	alternate sigil to the candle
"
const UPGRADE_DESCRIPTION : String = "
	Chance of double shroom
	Or double dollar
	Cost: {cost}
	Current Upgrade: {currently}%
"
const CONTRACT_SIGIL_SPRITE : CompressedTexture2D = preload("res://Sprites/Sigils/sigil10.png")
const CONTRACT_BACKGROUND_COLOR : Color = Color8(89, 60, 50)


#@ Virtual Methods
# L.B: If making a new contract, probably don't modify this function.
func _showPage() -> void:
	_contractName = CONTRACT_NAME
	_assignContractDescription()
	_contractSigilSprite = CONTRACT_SIGIL_SPRITE
	_contractBackgroundColor = CONTRACT_BACKGROUND_COLOR
	super._showPage()


func _purchaseUpgrade() -> void:
	if GVars.soulsData.doubleShroomChanceCost <= GVars.soulsData.souls:
		GVars.soulsData.doubleShroomChance += 15
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls -= GVars.soulsData.doubleShroomChanceCost
		GVars.soulsData.doubleShroomChanceCost += GVars.soulsData.doubleShroomChanceScaling
		# Update text.
		_assignContractDescription()
		_assignText()


func _isContractCompleted() -> bool:
	return GVars.soulsData.doubleShroomChanceEnabled


func _isUpgradeMaxed() -> bool:
	return GVars.soulsData.doubleShroomChance >= 90


#@ Private Methods
func _assignContractDescription() -> void:
	if _isContractCompleted():
		var upgradeDescription : String = UPGRADE_DESCRIPTION.format({"cost" : str(GVars.soulsData.doubleShroomChanceCost), "currently" : str(GVars.soulsData.doubleShroomChance)})
		_contractDescription = upgradeDescription
	else:
		_contractDescription = CONTRACT_DESCRIPTION
