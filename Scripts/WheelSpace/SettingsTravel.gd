extends TextureButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self.setScene)


func setScene():
	EventManager.scene_change.emit()
	SceneHandler.changeSceneToPacked(SceneHandler.SETTINGS)
