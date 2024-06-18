extends Panel
class_name BackpackPanel


#@ Public Variables
var itemSelected : int


#@ Onready Variables
@onready var momentumLabel : Label = $MomentumLabel
@onready var rotationLabel : Label = $RotationLabel
@onready var rustLabel : Label = $RustLabel
@onready var cheese : TextureButton = $Cheese
@onready var ribbon : TextureButton = $Ribbon
@onready var choicePanel : Panel = $ChoicePanel


#@ Virtual Methods
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


#@ Private Methods
func _onBackpackPressed():
	momentumLabel.text = str(GVars.getScientific(GVars.spinData.spin))
	rotationLabel.text = str(GVars.getScientific(GVars.spinData.rotations))
	rustLabel.text = str(GVars.getScientific(GVars.rustData.rust))


func _onCheeseFocusEntered():
	cheese.scale = Vector2(1.2,1.2)


func _onCheeseFocusExited():
	cheese.scale = Vector2(1,1)


func _onRibbonFocusEntered():
	ribbon.scale = Vector2(0.399,0.399)


func _onRibbonFocusExited():
	ribbon.scale = Vector2(0.333,0.333)


func _onCheesePressed():
	itemSelected = 0
	choicePanel.show()


func _onRibbonPressed():
	itemSelected = 1
	choicePanel.show()


func _onSelfPressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()


func _onPacksmithPressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()


func _onFaePressed():
	if itemSelected == 0:
		choicePanel.hide()
	elif itemSelected == 1:
		choicePanel.hide()
	else:
		choicePanel.hide()


func _onZundaPressed():
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
