extends GameScene


#@ Onready Variables
@onready var rightButton : BaseButton = $RightButton
@onready var backButton : BaseButton = $BackButton
@onready var finishContractButton : Button = $FinishContractButton
@onready var openContractsButton : Button = $OpenContractsButton

@onready var backgroundSprite : AnimatedSprite2D = $Background
@onready var dialogueControl : Control = $DialogueControl
@onready var contractMenu : ContractMenu = $ContractMenu


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide/Show
	openContractsButton.hide()
	dialogueControl.hide()
	
	# Connect signals
	rightButton.pressed.connect(_onRightPressed)
	backButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.WHEELSPACE))
	finishContractButton.pressed.connect(contractMenu.displayContractPageButtons)
	openContractsButton.pressed.connect(_onOpenContractsPressed)
	dialogueControl.dialogueCompleted.connect(_onDialogueCompleted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Private Methods
func _onOpenContractsPressed() -> void:
	contractMenu.position = Vector2(0.0, 0.0)
	contractMenu.show()
	contractMenu.displayContractPage()


func _onRightPressed() -> void:
	rightButton.hide()
	
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
		
		dialogueControl.hide()


func _onDialogueCompleted() -> void:
	openContractsButton.show()
	backgroundSprite.frame = 2
