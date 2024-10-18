extends GameScene
#@ Onready Variables
@onready var rightButton : BaseButton = $RightButton
@onready var backButton : BaseButton = $BackButton
@onready var downButton : BaseButton = $DownButton
@onready var finishContractButton : Button = $FinishContractButton
@onready var openContractsButton : Button = $OpenContractsButton
@onready var openSigilSwapButton : Button = $OpenSigilSwapButton

@onready var backgroundSprite : AnimatedSprite2D = $Background
@onready var dialogueControl : Control = $DialogueControl
@onready var contractMenu : Control = $ContractMenu
@onready var sigilSwapPanel : Control = $SigilSwap


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide/Show
	openContractsButton.hide()
	dialogueControl.hide()
	openSigilSwapButton.hide()
	
	# Connect signals
	rightButton.pressed.connect(_onRightPressed)
	backButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.WHEELSPACE))
	downButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.FEARCAT))
	finishContractButton.pressed.connect(contractMenu.displayContractPageButtons)
	openContractsButton.pressed.connect(_onOpenContractsPressed)
	openSigilSwapButton.pressed.connect(_onOpenSigilSwapPressed)
	dialogueControl.dialogueCompleted.connect(_onDialogueCompleted)
	contractMenu.ContractMenuExit.connect(_show_swap_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Private Methods
func _onOpenContractsPressed() -> void:
	contractMenu.position = Vector2(0.0, 0.0)
	contractMenu.show()
	contractMenu.displayContractPage()
	openSigilSwapButton.hide()


func _onRightPressed() -> void:
	rightButton.hide()
	downButton.hide()
	if GVars.ifFirstHell:
		backgroundSprite.frame = 1
		openContractsButton.hide()
		
		dialogueControl.show()
		dialogueControl.zundaBodySprite.frame = 1
		dialogueControl.zundaFaceSprite.frame = 0
		GVars._dialouge(dialogueControl.dialogueLabel.text, str(0), 0.02)
	else:
		backgroundSprite.frame = 2
		openContractsButton.show()
		if GVars.challenges.has(GVars.CHALLENGE_SANDY) or GVars.challenges.has(GVars.CHALLENGE_BITTERSWEET) or GVars.challenges.has(GVars.CHALLENGE_STARVED) or GVars.challenges.has(GVars.CHALLENGE_FABULOUS):
			openSigilSwapButton.show()
		dialogueControl.hide()


func _onDialogueCompleted() -> void:
	openContractsButton.show()
	if GVars.challenges.has(GVars.CHALLENGE_SANDY) or GVars.challenges.has(GVars.CHALLENGE_BITTERSWEET) or GVars.challenges.has(GVars.CHALLENGE_STARVED) or GVars.challenges.has(GVars.CHALLENGE_FABULOUS):
		openSigilSwapButton.show()
	backgroundSprite.frame = 2

func _onOpenSigilSwapPressed() -> void:
	openContractsButton.hide()
	openSigilSwapButton.hide()
	sigilSwapPanel.show()


func _on_swap_exit_button_pressed():
	sigilSwapPanel.hide()
	openContractsButton.show()
	openSigilSwapButton.show()
	
func _show_swap_button():
	if GVars.challenges.has(GVars.CHALLENGE_SANDY) or GVars.challenges.has(GVars.CHALLENGE_BITTERSWEET) or GVars.challenges.has(GVars.CHALLENGE_STARVED) or GVars.challenges.has(GVars.CHALLENGE_FABULOUS):
		openSigilSwapButton.show()
