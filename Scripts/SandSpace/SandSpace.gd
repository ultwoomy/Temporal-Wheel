extends Control


#@ Constants
const LIGHT_SIGIL_TEXTURE : CompressedTexture2D = preload("res://Sprites/Sigils/sigil10.png")
const DARK_SIGIL_TEXTURE : CompressedTexture2D = preload("res://Sprites/SandSpace/invert_sand_sigil.png")


#@ Onready Variables
@onready var achievementPanel : Panel = $Achieve
@onready var insurancePanel : Panel = $Insurance
@onready var invert : TextureButton = $Invert
@onready var background : AnimatedSprite2D = $Background
@onready var dollarLabel : Label = $Invert/DollarLabel
@onready var backButton : TextureButton = $BackButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	achievementPanel.achievementCompleted.connect(self.updateLabel)
	updateLabel()
	achievementPanel.show()
	insurancePanel.hide()
	invert.texture_normal = LIGHT_SIGIL_TEXTURE
	invert.texture_disabled = LIGHT_SIGIL_TEXTURE
	invert.texture_pressed = DARK_SIGIL_TEXTURE
	invert.texture_hover = DARK_SIGIL_TEXTURE
	invert.texture_focused = DARK_SIGIL_TEXTURE
	background.frame = 0
	
	# Connect signals.
	backButton.pressed.connect(SceneHandler.changeSceneToFilePath.bind(SceneHandler.WHEELSPACE))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#@ Public Methods
func updateLabel():
	if GVars.SIGIL_SAND in GVars.sigilData.acquiredSigils:
		dollarLabel.text = "Dollar Sigil: Active\nMultiply Identity bonus by " + str(GVars.getScientific(pow(GVars.dollarData.sandDollars,2)))
		## TODO:
		#if GVars.sigilData.currentAugmentedSigil == 9:
			#dollarLabel.text += "\nMultiply Rotation gain by: " + str(GVars.getScientific(GlobalBuffs.dollarRotationModifier))
	else:
		dollarLabel.text = "Dollar Sigil: Inactive"


#@ Private Methods
func _onInvertButtonPressed() -> void:
	if background.frame == 0:
		invert.texture_normal = DARK_SIGIL_TEXTURE
		invert.texture_disabled = DARK_SIGIL_TEXTURE
		invert.texture_pressed = LIGHT_SIGIL_TEXTURE
		invert.texture_hover = LIGHT_SIGIL_TEXTURE
		invert.texture_focused = LIGHT_SIGIL_TEXTURE
		background.frame = 1
		achievementPanel.hide()
		insurancePanel.show()
	else:
		invert.texture_normal = LIGHT_SIGIL_TEXTURE
		invert.texture_disabled = LIGHT_SIGIL_TEXTURE
		invert.texture_pressed = DARK_SIGIL_TEXTURE
		invert.texture_hover = DARK_SIGIL_TEXTURE
		invert.texture_focused = DARK_SIGIL_TEXTURE
		background.frame = 0
		achievementPanel.show()
		insurancePanel.hide()
