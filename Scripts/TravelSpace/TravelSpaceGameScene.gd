extends GameScene


#@ Constants
var WINDOW_SPRITE : CompressedTexture2D = preload("res://Sprites/Spaces/window.png")
var WINDOW_ALT_SPRITE : CompressedTexture2D = preload("res://Sprites/Spaces/window_alt.png")


#@ Public Variables
var showTop : bool = true


#@ Onready Variables
@onready var topButtons : Control = $TopButtons
@onready var bottomButtons : Control = $BottomButtons
@onready var swapButton : TextureButton = $SwapButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	bottomButtons.hide()
	topButtons.show()
	
	# Connect signals.
	swapButton.pressed.connect(_onSwapButtonPressed)


#@ Private Methods
func _onSwapButtonPressed() -> void:
	if showTop:
		bottomButtons.show()
		topButtons.hide()
		swapButton.texture_normal = WINDOW_ALT_SPRITE
		swapButton.texture_disabled = WINDOW_ALT_SPRITE
		swapButton.texture_pressed = WINDOW_SPRITE
		swapButton.texture_hover = WINDOW_SPRITE
		swapButton.texture_focused = WINDOW_SPRITE
		showTop = false
	else:
		bottomButtons.hide()
		topButtons.show()
		swapButton.texture_normal = WINDOW_SPRITE
		swapButton.texture_disabled = WINDOW_SPRITE
		swapButton.texture_pressed = WINDOW_ALT_SPRITE
		swapButton.texture_hover = WINDOW_ALT_SPRITE
		swapButton.texture_focused = WINDOW_ALT_SPRITE
		showTop = true
