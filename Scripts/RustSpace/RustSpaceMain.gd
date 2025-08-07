extends GameScene


#@ Onready Variables
@onready var background : Sprite2D = $Background
@onready var insideButton : Button = $InsideButton
@onready var backButton : Button = $BackButton
@onready var enterAtlasButton : Button = $EnterAtlasButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unlockAtlas()
	
	# Connect signals.
	insideButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.PACKSMITH))
	backButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.WHEELSPACE))
	enterAtlasButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.ATLAS))


#@ Public Methods
func unlockAtlas() -> void:
	enterAtlasButton.hide()
	if GVars.curEmotionBuff == 4 or not GVars.ifFirstAtlas:
		enterAtlasButton.show()


#@ Private Methods
