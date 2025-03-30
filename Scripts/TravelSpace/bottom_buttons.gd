extends Container

@onready var sandspace : Button = $SandButton
@onready var huntspace : Button = $HuntButton

const sandSigil : Sigil = preload("res://Resources/Sigil/SandDollar.tres")
const huntSigil : Sigil = preload("res://Resources/Sigil/ZundaNightSigil.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sandspace.size = Vector2(500,300)
	sandspace.position = Vector2(0,0)
	huntspace.size = Vector2(500,300)
	huntspace.position = Vector2(500,0)
	if sandSigil in GVars.sigilData.acquiredSigils or not GVars.ifFirstDollar:
		sandspace.disabled = false
	else:
		sandspace.disabled = true
	if huntSigil in GVars.sigilData.acquiredSigils or not GVars.ifFirstHunt:
		huntspace.disabled = false
	else:
		huntspace.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sand_button_pressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.SANDSPACE)


func _on_hunt_button_pressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.HUNTSPACE)
