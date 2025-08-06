extends Control


#@ Onready Variables
@onready var sandspaceButton : Button = $SandButton
@onready var huntspaceButton : Button = $HuntButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals.
	sandspaceButton.pressed.connect(_changeScene.bind(SceneHandler.SANDSPACE))
	huntspaceButton.pressed.connect(_changeScene.bind(SceneHandler.HUNTSPACE))
	
	# Unlock areas the Player can go to.
	var sandSpaceUnlockRequirement : bool = GVars.SIGIL_SAND in GVars.sigilData.acquiredSigils or not GVars.ifFirstDollar
	sandspaceButton.disabled = not sandSpaceUnlockRequirement
	
	var huntSpaceUnlockRequirement : bool = GVars.SIGIL_ZUNDANIGHT in GVars.sigilData.acquiredSigils or not GVars.ifFirstHunt
	huntspaceButton.disabled = not huntSpaceUnlockRequirement


#@ Private Methods
func _changeScene(scenePath : String) -> void:
	SceneHandler.changeSceneToFilePath(scenePath)
