extends Control


#@ Onready Variables
@onready var sandspace : Button = $SandButton
@onready var huntspace : Button = $HuntButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GVars.SIGIL_SAND in GVars.sigilData.acquiredSigils or not GVars.ifFirstDollar:
		sandspace.disabled = false
	else:
		sandspace.disabled = true
	if GVars.SIGIL_ZUNDANIGHT in GVars.sigilData.acquiredSigils or not GVars.ifFirstHunt:
		huntspace.disabled = false
	else:
		huntspace.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#@ Private Methods
func _on_sand_button_pressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.SANDSPACE)


func _on_hunt_button_pressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.HUNTSPACE)
