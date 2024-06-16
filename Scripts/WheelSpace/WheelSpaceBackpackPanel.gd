extends Panel

@onready var momentumLabel : Label = $MomentumLabel
@onready var rotationLabel : Label = $RotationLabel
@onready var rustLabel : Label = $RustLabel
@onready var cheese : TextureButton = $Cheese
@onready var ribbon : TextureButton = $Ribbon
@onready var choicePanel : Panel = $ChoicePanel
var itemSelected : int

# Called when the node enters the scene tree for the first time.
func _ready():
	itemSelected = 0
	choicePanel.hide()
	cheese.hide()
	ribbon.hide()
	if GVars.backpackData.cheese:
		cheese.show()
	if GVars.backpackData.ribbon:
		ribbon.show()
	if GVars.iffirsthell:
		choicePanel.get_child(3).hide()


func _on_backpack_pressed():
	momentumLabel.text = str(GVars.getScientific(GVars.spinData.spin))
	rotationLabel.text = str(GVars.getScientific(GVars.spinData.rotations))
	rustLabel.text = str(GVars.getScientific(GVars.rustData.rust))

func _on_cheese_focus_entered():
	cheese.scale = Vector2(1.2,1.2)

func _on_cheese_focus_exited():
	cheese.scale = Vector2(1,1)
	
func _on_ribbon_focus_entered():
	ribbon.scale = Vector2(0.399,0.399)

func _on_ribbon_focus_exited():
	ribbon.scale = Vector2(0.333,0.333)

func _on_cheese_pressed():
	itemSelected = 0
	choicePanel.show()

func _on_ribbon_pressed():
	itemSelected = 1
	choicePanel.show()

func _on_self_pressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()

func _on_packsmith_pressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()

func _on_fae_pressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()
	
func _on_zunda_pressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()
	
func _on_rat_cheese_pressed():
	_ready()

func _on_real_bow_pressed():
	_ready()

