extends Control
class_name ContractMenu


#@ Public Variables
var contractOrder : Array = [  # (!) Elements should be derived from CMP_Strategy
	CMP_SandStrategy,
	CMP_UndercityStrategy,
	CMP_ZundaStrategy,
	CMP_TwinsStrategy,
]
var contractStrategy : CMP_Strategy
var contractIndex : int = 0


#@ Onready Variables
@onready var contractPage : ContractPage = $ContractPage

@onready var leftArrowButton : TextureButton = $LeftArrowButton
@onready var rightArrowButton : TextureButton = $RightArrowButton
@onready var exitButton : TextureButton = $ExitButton
@onready var enterContractButton : Button = $EnterContractButton
@onready var soulUpgradeButton : Button = $SoulUpgradeButton

@onready var SoulCountSprite : Sprite2D = $SoulCountContainer/SoulCountSprite
@onready var soulCountLabel : Label = $SoulCountContainer/SoulCountLabel


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initial Strategy.
	contractStrategy = contractOrder[contractIndex].new(contractPage)
	
	self.hide()
	soulUpgradeButton.hide()


func _process(_delta : float) -> void:
	if contractStrategy:
		const ROTATION_AMOUNT : float = 1.0
		contractStrategy.rotateSigil(ROTATION_AMOUNT)
	
	soulCountLabel.text = str(GVars.getScientific(GVars.soulsData.souls))


#@ Public Methods
func toTheLeft() -> void:
	contractIndex -= 1
	if contractIndex < 0:
		contractIndex = contractOrder.size() - 1
	contractStrategy = contractOrder[contractIndex].new(contractPage)
	displayContractPage()


func toTheRight() -> void:
	contractIndex += 1
	if contractIndex >= contractOrder.size():
		contractIndex = 0
	contractStrategy = contractOrder[contractIndex].new(contractPage)
	displayContractPage()


func displayContractPage() -> void:
	contractStrategy._showPage()
	if contractStrategy._isContractCompleted():
		enterContractButton.hide()
		soulUpgradeButton.show()
		_disableUpgradePurchase(contractStrategy._isUpgradeMaxed())
	else:
		enterContractButton.show()
		soulUpgradeButton.hide()


func beginContract() -> void:
	GVars.setChallenge(contractStrategy._getChallenge())
	GVars.hellChallengeLayer2 = contractIndex
	GVars.hellChallengeInit = true
	SceneHandler.changeSceneToFilePath(SceneHandler.ASCENSIONSPACE)


#@ Private Methods
func _disableUpgradePurchase(boolean : bool) -> void:
	soulUpgradeButton.disabled = boolean
	if boolean:
		soulUpgradeButton.text = "Maxed"
	else:
		soulUpgradeButton.text = "Upgrade"


func _onExitPressed() -> void:
	contractIndex = 0
	self.hide()


func _onSoulUpgradePressed() -> void:
	contractStrategy._purchaseUpgrade()
	_disableUpgradePurchase(contractStrategy._isUpgradeMaxed())
