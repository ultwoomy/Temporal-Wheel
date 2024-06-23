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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func unlockAtlas() -> void:
	enterAtlasButton.hide()
	if GVars.curEmotionBuff == 4 or not GVars.ifFirstAtlas:
		enterAtlasButton.show()


#@ Private Methods
func _onInsideButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.PACKSMITH)


func _onBackButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)


func _onEnterAtlasButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.ATLAS)
