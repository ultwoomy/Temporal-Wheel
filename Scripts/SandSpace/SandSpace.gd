extends Control
@onready var achievementPanel : Panel = $Achieve
@onready var insurancePanel : Panel = $Insurance
@onready var invert : TextureButton = $Invert
@onready var background : AnimatedSprite2D = $Background
@onready var dollarLabel : Label = $Invert/DollarLabel

var lightSigil = preload("res://Sprites/Sigils/sigil10.png")
var darkSigil = preload("res://Sprites/SandSpace/invert_sand_sigil.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	achievementPanel.achievementCompleted.connect(self.updateLabel)
	updateLabel()
	achievementPanel.show()
	insurancePanel.hide()
	invert.texture_normal = lightSigil
	invert.texture_disabled = lightSigil
	invert.texture_pressed = darkSigil
	invert.texture_hover = darkSigil
	invert.texture_focused = darkSigil
	background.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_invert_pressed() -> void:
	if background.frame == 0:
		invert.texture_normal = darkSigil
		invert.texture_disabled = darkSigil
		invert.texture_pressed = lightSigil
		invert.texture_hover = lightSigil
		invert.texture_focused = lightSigil
		background.frame = 1
		achievementPanel.hide()
		insurancePanel.show()
	else:
		invert.texture_normal = lightSigil
		invert.texture_disabled = lightSigil
		invert.texture_pressed = darkSigil
		invert.texture_hover = darkSigil
		invert.texture_focused = darkSigil
		background.frame = 0
		achievementPanel.show()
		insurancePanel.hide()

func updateLabel():
	if GVars.SIGIL_SAND in GVars.sigilData.acquiredSigils:
		dollarLabel.text = "Dollar Sigil: Active\nMultiply Identity bonus by " + str(GVars.getScientific(pow(GVars.dollarData.sandDollars,2)))
		## TODO:
		#if GVars.sigilData.currentAugmentedSigil == 9:
			#dollarLabel.text += "\nMultiply Rotation gain by: " + str(GVars.getScientific(GlobalBuffs.dollarRotationModifier))
	else:
		dollarLabel.text = "Dollar Sigil: Inactive"
	
