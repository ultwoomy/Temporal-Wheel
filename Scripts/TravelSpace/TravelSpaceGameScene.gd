extends GameScene


#@ Export Variables


#@ Onready Variables
@onready var rustButton : Button = $RustButton
@onready var voidButton : Button = $VoidButton
@onready var heavenButton : Button = $HeavenButton
@onready var hellButton : Button = $HellButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	rustButton.pressed.connect(self._button_pressed)
	voidButton.pressed.connect(self._button_pressed2)
	heavenButton.pressed.connect(self._button_pressed3)
	hellButton.pressed.connect(self._button_pressed4)
	
	if not GVars.ifheaven:
		heavenButton.disabled = true
	if not GVars.ifhell:
		hellButton.disabled = true


#@ Private Methods
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.RUSTSPACE_OUTSIDE)


func _button_pressed2():
	SceneHandler.changeSceneToFilePath(SceneHandler.VOIDSPACE_STOP)


func _button_pressed3():
	SceneHandler.changeSceneToFilePath(SceneHandler.HELLSPACE)


func _button_pressed4():
	SceneHandler.changeSceneToFilePath(SceneHandler.HELLSPACE)
