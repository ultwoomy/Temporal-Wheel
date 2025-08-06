extends GameScene


#@ Constants
const WINDOW_TEXTURE : CompressedTexture2D = preload("res://Sprites/Spaces/window.png")
const WINDOW_ALT_TEXTURE : CompressedTexture2D = preload("res://Sprites/Spaces/window_alt.png")


#@ Public Variables
var showTop : bool = true


#@ Onready Variables
@onready var topButtons : Control = $TopButtons
@onready var bottomButtons : Control = $BottomButtons
@onready var swapButton : TextureButton = $SwapButton
@onready var backButton : TextureButton = $BackButton

## TODO:
##  L.B: The two scripts of the buttons are separate.
##   It may be plausible to use one script instead.

#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	bottomButtons.hide()
	topButtons.show()
	
	# Connect signals.
	swapButton.pressed.connect(_onSwapButtonPressed)
	backButton.pressed.connect(_changeScene.bind(SceneHandler.WHEELSPACE))


#@ Private Methods
func _onSwapButtonPressed() -> void:
	if showTop:
		bottomButtons.show()
		topButtons.hide()
		swapButton.texture_normal = WINDOW_ALT_TEXTURE
		swapButton.texture_disabled = WINDOW_ALT_TEXTURE
		swapButton.texture_pressed = WINDOW_TEXTURE
		swapButton.texture_hover = WINDOW_TEXTURE
		swapButton.texture_focused = WINDOW_TEXTURE
		showTop = false
	else:
		bottomButtons.hide()
		topButtons.show()
		swapButton.texture_normal = WINDOW_TEXTURE
		swapButton.texture_disabled = WINDOW_TEXTURE
		swapButton.texture_pressed = WINDOW_ALT_TEXTURE
		swapButton.texture_hover = WINDOW_ALT_TEXTURE
		swapButton.texture_focused = WINDOW_ALT_TEXTURE
		showTop = true


func _changeScene(scenePath : String) -> void:
	SceneHandler.changeSceneToFilePath(scenePath)
