extends Control
@onready var achievementPanel : Panel = $Achieve
@onready var insurancePanel : Panel = $Insurance
@onready var invert : TextureButton = $Invert
@onready var background : AnimatedSprite2D = $Background
@onready var dollarLabel : Label = $Invert/DollarLabel
const sandSigil : Sigil = preload("res://Resources/Sigil/SandDollar.tres")
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
		achievementPanel.show()
		insurancePanel.hide()
	else:
		invert.texture_normal = lightSigil
		invert.texture_disabled = lightSigil
		invert.texture_pressed = darkSigil
		invert.texture_hover = darkSigil
		invert.texture_focused = darkSigil
		background.frame = 0
		achievementPanel.hide()
		insurancePanel.show()

func updateLabel():
	dollarLabel.text = "Dollar Sigil: "
	
