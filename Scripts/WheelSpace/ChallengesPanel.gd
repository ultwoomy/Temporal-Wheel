extends Control
class_name ChallengesPanel


#@ Onready Variables
@onready var sigilSprite : Sprite2D = $SigilInfo/Sprite2D
@onready var sigilLabel : Label = $SigilInfo/Label

@onready var challengeLabelFirst : Label = $FirstChallengeLabel
@onready var challengeLabelSecond : Label = $SecondChallengeLabel


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_displayAugmentedSigil()
	_displayCurrentChallenges()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Private Methods
func _displayAugmentedSigil() -> void:
	sigilLabel.text = "Sigil Augmented:\n"
	if GVars.sigilData.currentAugmentedSigil:
		sigilLabel.text += GVars.sigilData.currentAugmentedSigil.sigilName.capitalize()
		sigilSprite.modulate = Color(1, 1, 1, 1)
		sigilSprite.texture = GVars.sigilData.currentAugmentedSigil.spriteTexture
	else:
		sigilLabel.text += "None"
		sigilSprite.modulate = Color(0, 0, 0, 1)


func _displayCurrentChallenges() -> void:
	if GVars.currentChallenges.size() >= 2:
		challengeLabelSecond.text = GVars.currentChallenges[1].name
		challengeLabelFirst.text = GVars.currentChallenges[0].name
	elif GVars.currentChallenges.size() == 1:
		challengeLabelFirst.text = GVars.currentChallenges[0].name
	else:
		challengeLabelSecond.text = ""
		challengeLabelFirst.text = ""
