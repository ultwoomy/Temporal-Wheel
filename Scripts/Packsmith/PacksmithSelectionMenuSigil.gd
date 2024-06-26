extends Control
class_name SelectionMenuSigil


#@ Public Variables
var sigil : Sigil


#@ Onready Variables
@onready var sprite : Sprite2D = $SigilSprite
@onready var button : Button = $SigilButton


#@ Public Methods
func setSigil(_sigil : Sigil) -> void:
	sigil = _sigil
	sprite.texture = _sigil.spriteTexture
