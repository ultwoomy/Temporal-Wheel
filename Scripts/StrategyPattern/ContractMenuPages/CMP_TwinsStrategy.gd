extends CMP_Strategy
class_name CMP_TwinsStrategy


#@ Constants
const CONTRACT_NAME : String = "The Twins"
const CONTRACT_DESCRIPTION : String = "
	You no longer gain resources
	Rust can purchase all resource
	Unlocks the Twins as an
	alternate sigil to the Packsmith (WIP)
"
const UPGRADE_DESCRIPTION : String = "
	Chance of void rust
	Or double rust
	Cost: {cost}
	Currently: {currently}%
"
const CONTRACT_SIGIL_SPRITE : CompressedTexture2D = preload("res://Sprites/Sigils/sigil13.png")
const CONTRACT_BACKGROUND_COLOR : Color = Color8(0, 66, 41)  # (!) Make sure to put in the values from the RAW tab in color!


#@ Virtual Methods
# L.B: If making a new contract, probably don't modify this function.
func _showPage() -> void:
	_contractName = CONTRACT_NAME
	_assignContractDescription()
	_contractSigilSprite = CONTRACT_SIGIL_SPRITE
	_contractBackgroundColor = CONTRACT_BACKGROUND_COLOR
	super._showPage()


func _purchaseUpgrade() -> void:
	if(GVars.soulsData.voidRustChanceCost <= GVars.soulsData.souls):
		GVars.soulsData.voidRustChance += 15
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls -= GVars.soulsData.voidRustChanceCost
		GVars.soulsData.voidRustChanceCost += GVars.soulsData.voidRustChanceScaling
		# Update text.
		_assignContractDescription()
		_assignText()


func _getChallenge() -> ChallengeData:
	return GVars.CHALLENGE_FABULOUS


func _isContractCompleted() -> bool:
	return GVars.soulsData.voidRustChanceEnabled


func _isUpgradeMaxed() -> bool:
	return GVars.soulsData.voidRustChance >= 90


#@ Private Methods
func _assignContractDescription() -> void:
	if _isContractCompleted():
		var upgradeDescription : String = UPGRADE_DESCRIPTION.format({"cost" : str(GVars.soulsData.doubleShroomChanceCost), "currently" : str(GVars.soulsData.doubleShroomChance)})
		_contractDescription = upgradeDescription
	else:
		_contractDescription = CONTRACT_DESCRIPTION
