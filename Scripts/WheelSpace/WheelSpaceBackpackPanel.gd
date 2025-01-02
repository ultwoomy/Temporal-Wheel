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
@onready var drum :TextureButton = $Drum


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	itemSelected = 0
	cheese.hide()
	ribbon.hide()
	drum.hide()
	
	if GVars.backpackData.cheese:
		cheese.show()
	if GVars.backpackData.ribbon:
		ribbon.show()
	if GVars.backpackData.drum:
		drum.show()


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



func _on_rat_cheese_pressed():
	_ready()


func _on_real_bow_pressed():
	_ready()


func _on_drum_focus_entered():
	drum.scale = Vector2(0.48,0.48)


func _on_drum_focus_exited():
	drum.scale = Vector2(0.4,0.4)


func _on_drum_pressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.MUSICBOX)
