extends Container

@onready var sandspace : Button = $SandButton

const sandSigil : Sigil = preload("res://Resources/Sigil/SandDollar.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sandspace.size = Vector2(500,300)
	sandspace.position = Vector2(0,0)
	if sandSigil in GVars.sigilData.acquiredSigils or not GVars.ifFirstDollar:
		sandspace.disabled = false
	else:
		sandspace.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sand_button_pressed() -> void:
	SceneHandler.changeSceneToFilePath(SceneHandler.SANDSPACE)
