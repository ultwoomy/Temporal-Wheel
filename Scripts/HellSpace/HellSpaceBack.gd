extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._wheelScene)


func _wheelScene():
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
