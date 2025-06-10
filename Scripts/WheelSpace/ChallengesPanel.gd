extends Control
class_name ChallengesPanel


#@ Onready Variables
@onready var sigilSprite : Sprite2D = $SigilSprite


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## TODO: Set texture to current sigil texture.
	## Need to receive sigil. Should be curSigilBuff... but I don't like that.
	## Need to change curSigilBuff.
	if GVars.sigilData.currentAugmentedSigil:
		sigilSprite.texture = GVars.sigilData.currentAugmentedSigil.spriteTexture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
