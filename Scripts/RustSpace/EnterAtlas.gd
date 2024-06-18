extends Button


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	if GVars.curEmotionBuff == 4 or not GVars.iffirstatlas:
		show()
	
	pressed.connect(self._buttonPressed)


#@ Private Methods
func _buttonPressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.ATLAS)
