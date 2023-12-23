extends TextureButton
@export var backdrop : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_pressed():
	hide()
	backdrop.frame = 1
