extends GameScene


#@ Public Variables
var topWindow = preload("res://Sprites/Spaces/window.png")
var bottomWinodw = preload("res://Sprites/Spaces/window_alt.png")
var showTop = true

#@ Onready Variables
@onready var topButtons : Control = $TopButtons
@onready var bottomButtons : Control = $BottomButtons
@onready var swapButton : TextureButton = $SwapButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	bottomButtons.hide()
	topButtons.show()
	swapButton.texture_normal = topWindow
	swapButton.texture_disabled = topWindow
	swapButton.texture_pressed = bottomWinodw
	swapButton.texture_hover = bottomWinodw
	swapButton.texture_focused = bottomWinodw


func _on_swap_button_pressed() -> void:
	if showTop:
		bottomButtons.show()
		topButtons.hide()
		swapButton.texture_normal = bottomWinodw
		swapButton.texture_disabled = bottomWinodw
		swapButton.texture_pressed = topWindow
		swapButton.texture_hover = topWindow
		swapButton.texture_focused = topWindow
		showTop = false
	else:
		bottomButtons.hide()
		topButtons.show()
		swapButton.texture_normal = topWindow
		swapButton.texture_disabled = topWindow
		swapButton.texture_pressed = bottomWinodw
		swapButton.texture_hover = bottomWinodw
		swapButton.texture_focused = bottomWinodw
		showTop = true
