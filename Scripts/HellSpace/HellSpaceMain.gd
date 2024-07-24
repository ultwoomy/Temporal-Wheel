extends GameScene


#@ Onready Variables
@onready var rightButton : BaseButton = $RightButton
@onready var backButton : BaseButton = $BackButton
@onready var openContractsButton : Button = $OpenContractsButton

@onready var backgroundSprite : AnimatedSprite2D = $Background
@onready var dialogueContainer : Control = $DialogueContainer
@onready var contractMenu : ContractMenu = $ContractMenu


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide/Show
	openContractsButton.hide()
	dialogueContainer.hide()
	
	# Connect signals
	rightButton.pressed.connect(_onRightPressed)
	backButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.WHEELSPACE))
	openContractsButton.pressed.connect(_onOpenContractsPressed)
	dialogueContainer.dialogueCompleted.connect(_onDialogueCompleted)


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
		
		dialogueContainer.show()
		dialogueContainer.zundaBodySprite.frame = 1
		dialogueContainer.zundaFaceSprite.frame = 0
		GVars._dialouge(dialogueContainer.dialogueLabel.text, 0, 0.02)
		dialogueContainer.dialogueLabel.text = dialogueContainer.dialouge[0]
	else:
		backgroundSprite.frame = 2
		openContractsButton.show()
		
		dialogueContainer.hide()


func _onDialogueCompleted() -> void:
	openContractsButton.show()
	backgroundSprite.frame = 2
