extends TextureButton
@export var backdrop : AnimatedSprite2D
@export var zunda1 : AnimatedSprite2D
@export var zunda2 : AnimatedSprite2D
@export var textbox : Sprite2D
@export var text : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	zunda1.hide()
	zunda2.hide()
	textbox.hide()
	text.hide()

func _on_pressed():
	hide()
	backdrop.frame = 1
	zunda1.show()
	zunda1.frame = 1
	zunda2.show()
	zunda2.frame = 0
	textbox.show()
	text.show()
