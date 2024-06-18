extends Node


#@ Export Variables
@export var button : Button


#@ Global Variables


#@ Onready Variables


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(self._buttonPressed)


#@ Private Methods
func _buttonPressed():
	SceneHandler.changeSceneToPacked(SceneHandler.WHEELSPACE)
