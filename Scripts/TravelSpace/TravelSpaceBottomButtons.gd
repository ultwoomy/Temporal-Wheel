extends Control


#@ Onready Variables
@onready var sandspaceButton : Button = $SandButton
@onready var huntspaceButton : Button = $HuntButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GVars.SIGIL_SAND in GVars.sigilData.acquiredSigils or not GVars.ifFirstDollar:
		sandspaceButton.disabled = false
	else:
		sandspaceButton.disabled = true
	if GVars.SIGIL_ZUNDANIGHT in GVars.sigilData.acquiredSigils or not GVars.ifFirstHunt:
		huntspaceButton.disabled = false
	else:
		huntspaceButton.disabled = true


#@ Private Methods
# TODO: Have this be one function with a match keyword
func _onSandButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.SANDSPACE)


func _onHuntButtonPressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.HUNTSPACE)
