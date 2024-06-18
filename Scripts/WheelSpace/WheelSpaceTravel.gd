extends Node


#@ Export Variable
@export var button : Button


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	button.size = Vector2(200,100)
	button.text = "Travel"
	button.expand_icon = true
	button.pressed.connect(self._buttonPressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _buttonPressed():
	SceneHandler.changeSceneToPacked(SceneHandler.TRAVELSPACE)
