extends TextureButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._wheelScene)


#@ Private Methods
func _wheelScene():
	SceneHandler.changeSceneToPacked(SceneHandler.WHEELSPACE)
