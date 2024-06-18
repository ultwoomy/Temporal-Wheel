extends Node


#@ Export Variables
@export var back : Button


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	back.pressed.connect(self._wheelScene)


#@ Private Methods
func _wheelScene():
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
