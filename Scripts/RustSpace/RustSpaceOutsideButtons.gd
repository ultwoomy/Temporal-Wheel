extends Node


#@ Export Variables
@export var button : Button


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = str("Enter hole")
	button.size = Vector2(100,100)
	button.expand_icon = true
	button.pressed.connect(self._buttonPressed)


#@ Private Methods
func _buttonPressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.PACKSMITH)
