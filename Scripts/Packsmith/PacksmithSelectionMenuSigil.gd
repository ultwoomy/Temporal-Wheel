extends Control
class_name SelectionMenuSigil


#@ Components
@onready var sprite : Sprite2D = $SigilSprite
@onready var button : Button = $SigilButton


#@ Global Variables
# Assign this sigil instance to the correct sigil in the inspector.
# L.B: This variable can be handy in changing the sigil instance during runtime.
# 	For example:	You may not have the sigils in their designated spots later on...
#					But if you compare the sigil variable, you can determine the assigned sigil, and alter the sprite based on that.
@export var sigil : SigilData.Sigils
