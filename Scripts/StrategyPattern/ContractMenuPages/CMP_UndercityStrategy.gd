extends CMP_Strategy
class_name CMP_UndercityStrategy


#@ Constants
const CONTRACT_NAME : String = "Undercity"
const CONTRACT_DESCRIPTION : String = "
	Sigil costs are greatly modified
	The Kbity engine rumbles
	Unlocks the Undercity as an
	alternative sigil to the ritual
"
const UPGRADE_DESCRIPTION : String = "
	Chance of double rotations
	Cost: {cost}
	Current Upgrade: {currently}%
"
const CONTRACT_SIGIL_SPRITE : CompressedTexture2D = preload("res://Sprites/Sigils/sigil12.png")
const CONTRACT_BACKGROUND_COLOR : Color = Color8(113, 0, 108)


#@ Virtual Methods
# L.B: If making a new contract, probably don't modify this function.
func _showPage() -> void:
	_contractName = CONTRACT_NAME
	_assignContractDescription()
	_contractSigilSprite = CONTRACT_SIGIL_SPRITE
	_contractBackgroundColor = CONTRACT_BACKGROUND_COLOR
	super._showPage()


func _purchaseUpgrade() -> void:
	if GVars.soulsData.doubleRotChanceCost <= GVars.soulsData.souls:
		GVars.soulsData.doubleRotChance += 15
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls -= GVars.soulsData.doubleRotChanceCost
		GVars.soulsData.doubleRotChanceCost += GVars.soulsData.doubleRotChanceScaling
		# Update text.
		_assignContractDescription()
		_assignText()


func _isContractCompleted() -> bool:
	return GVars.soulsData.doubleRotChanceEnabled


func _isUpgradeMaxed() -> bool:
	return GVars.soulsData.doubleRotChance >= 90


#@ Private Methods
func _assignContractDescription() -> void:
	if _isContractCompleted():
		var upgradeDescription : String = UPGRADE_DESCRIPTION.format({"cost" : str(GVars.soulsData.spinBaseBuffCost), "currently" : str(GVars.soulsData.spinBaseBuff)})
		_contractDescription = upgradeDescription
	else:
		_contractDescription = CONTRACT_DESCRIPTION
