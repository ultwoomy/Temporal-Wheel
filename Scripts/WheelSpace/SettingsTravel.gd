extends TextureButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._setScene)


#@ Private Methods
func _setScene():
	SceneHandler.changeSceneToFilePath(SceneHandler.SETTINGS)
