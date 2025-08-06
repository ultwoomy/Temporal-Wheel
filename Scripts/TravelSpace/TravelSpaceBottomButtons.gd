extends Control


#@ Constants
const LOCATION_LOCK_TEXTURE : CompressedTexture2D = preload("res://Sprites/Spaces/location_lock.png")


#@ Onready Variables
@onready var sandspaceButton : Button = $SandButton
@onready var huntspaceButton : Button = $HuntButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals.
	sandspaceButton.pressed.connect(_changeScene.bind(SceneHandler.SANDSPACE))
	huntspaceButton.pressed.connect(_changeScene.bind(SceneHandler.HUNTSPACE))
	
	# Unlock areas the Player can go to.
	var sandSpaceUnlockRequirement : bool = GVars.SIGIL_SAND in GVars.sigilData.acquiredSigils or not GVars.ifFirstDollar
	sandspaceButton.disabled = not sandSpaceUnlockRequirement
	self._addLock(sandspaceButton)
	
	var huntSpaceUnlockRequirement : bool = GVars.SIGIL_ZUNDANIGHT in GVars.sigilData.acquiredSigils or not GVars.ifFirstHunt
	huntspaceButton.disabled = not huntSpaceUnlockRequirement
	self._addLock(huntspaceButton)


#@ Private Methods
func _changeScene(scenePath : String) -> void:
	SceneHandler.changeSceneToFilePath(scenePath)


func _addLock(button : Button) -> void:
	if button.disabled:
		var newSprite : Sprite2D = Sprite2D.new()
		newSprite.texture = LOCATION_LOCK_TEXTURE
		newSprite.offset = Vector2(LOCATION_LOCK_TEXTURE.get_width()/2.0, LOCATION_LOCK_TEXTURE.get_height()/2.0)
		button.add_child(newSprite)
