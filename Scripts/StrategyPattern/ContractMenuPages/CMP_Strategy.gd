class_name CMP_Strategy


#@ Public Variables
var contractPage : ContractPage


#@ Private Variables
# Contract info
var _contractName : String
var _contractDescription : String
var _contractSigilSprite : CompressedTexture2D
var _contractBackgroundColor : Color


#@ Virtual Methods
func _init(_contractPage : ContractPage) -> void:
	contractPage = _contractPage


# (!) Derived classes should call super._showPage() inside their own _showPage() func.
func _showPage() -> void:
	contractPage.show()
	_repositionPage()
	_assignName()
	_assignText()
	_assignSprite()
	_assignBackgroundColor()


func _purchaseUpgrade() -> void:
	pass


func _getChallenge() -> ChallengeData:
	return null


func _isContractCompleted() -> bool:
	return false


func _isUpgradeMaxed() -> bool:
	return false


#@ Public Methods
func rotateSigil(amount : float) -> void:
	contractPage.sigilSprite.rotation_degrees += amount


#@ Private Methods
func _repositionPage() -> void:
	var viewportSize : Vector2 = contractPage.get_viewport_rect().size
	var viewportWidth : float = float(viewportSize[0])
	var viewportHeight : float = float(viewportSize[1])
	contractPage.position = Vector2(viewportWidth / 2.0 - contractPage.size[0] / 2.0, viewportHeight / 2.0 - contractPage.size[1] / 2.0)


func _assignName() -> void:
	contractPage.nameLabel.text = _contractName


func _assignText() -> void:
	contractPage.descriptionLabel.text = _contractDescription


func _assignSprite() -> void:
	contractPage.sigilSprite.texture = _contractSigilSprite


func _assignBackgroundColor() -> void:
	contractPage.panel.modulate = _contractBackgroundColor
