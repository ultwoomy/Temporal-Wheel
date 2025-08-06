extends Control


#@ Constants
const LOCATION_LOCK_TEXTURE : CompressedTexture2D = preload("res://Sprites/Spaces/location_lock.png")


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
	self._addLock(heavenButton)
	
	var hellUnlockRequirement : bool = GVars.ifhell
	hellButton.disabled = not hellUnlockRequirement
	self._addLock(hellButton)


#@ Private Methods
func _changeScene(scenePath : String) -> void:
	SceneHandler.changeSceneToFilePath(scenePath)


func _addLock(button : Button) -> void:
	if button.disabled:
		var newSprite : Sprite2D = Sprite2D.new()
		newSprite.texture = LOCATION_LOCK_TEXTURE
		newSprite.offset = Vector2(LOCATION_LOCK_TEXTURE.get_width()/2.0, LOCATION_LOCK_TEXTURE.get_height()/2.0)
		button.add_child(newSprite)
