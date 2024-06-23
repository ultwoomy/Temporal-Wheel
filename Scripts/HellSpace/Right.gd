extends TextureButton
@export var backdrop : AnimatedSprite2D
@export var zunda1 : AnimatedSprite2D
@export var zunda2 : AnimatedSprite2D
@export var textbox : Sprite2D
@export var next : Button
@export var text : Label
@export var openCPage : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	zunda1.hide()
	zunda2.hide()
	textbox.hide()
	text.hide()
	next.hide()
	openCPage.hide()

func _on_pressed():
	backdrop.frame = 2
	if GVars.ifFirstHell:
		hide()
		backdrop.frame = 1
		zunda1.show()
		zunda1.frame = 1
		zunda2.show()
		zunda2.frame = 0
		textbox.show()
		text.show()
		next.show()
	else:
		hide()
