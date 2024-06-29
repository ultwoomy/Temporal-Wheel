extends Panel
@export var kbityOpenButton : Button
@export var kbitySprites : AnimatedSprite2D
@export var descText : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	if GVars.kbityData.kbityLevel < 2:
		kbitySprites.frame = GVars.kbityData.kbityLevel - 1
	else:
		kbitySprites.frame = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kbity_clone_button_pressed():
	if GVars.kbityData.kbityLevel < 2:
		kbitySprites.frame = GVars.kbityData.kbityLevel - 1
	else:
		kbitySprites.frame = 2
	descText.text = "Kbity Stats:\nLevel: " + str(GVars.kbityData.kbityLevel) + "\nEffect: x" + str(GVars.kbityData.kbityLevel + 2 /2) + " rotation multiplier."
