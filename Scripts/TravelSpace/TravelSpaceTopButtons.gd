extends Control


#@ Constants


#@ Export Variables


#@ Onready Variables
@onready var rustButton : Button = $RustButton
@onready var voidButton : Button = $VoidButton
@onready var heavenButton : Button = $HeavenButton
@onready var hellButton : Button = $HellButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signals.
	rustButton.pressed.connect(self._changeScene.bind(SceneHandler.RUSTSPACE_OUTSIDE))
	voidButton.pressed.connect(self._changeScene.bind(SceneHandler.VOIDSPACE_STOP))
	heavenButton.pressed.connect(self._changeScene.bind(SceneHandler.HELLSPACE))  # TODO
	hellButton.pressed.connect(self._changeScene.bind(SceneHandler.HELLSPACE))
	
	# Unlock areas the Player can go to.
	var heavenUnlockRequirement : bool = GVars.ifheaven
	heavenButton.disabled = not heavenUnlockRequirement
	
	var hellUnlockRequirement : bool = GVars.ifhell
	hellButton.disabled = not hellUnlockRequirement


#@ Private Methods
func _changeScene(scenePath : String) -> void:
	SceneHandler.changeSceneToFilePath(scenePath)
