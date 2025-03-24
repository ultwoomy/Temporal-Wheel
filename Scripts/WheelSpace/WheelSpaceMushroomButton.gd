extends TextureButton


#@ Public Variable
var dismush = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile002.png")
var mushNormal = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile000.png")
var mushPressed = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile001.png")
const candleSigil : Sigil = preload("res://Resources/Sigil/CandleSigil.tres")


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if candleSigil in GVars.sigilData.acquiredSigils:
		disabled = false
		texture_normal = mushNormal
		texture_hover = mushPressed
		texture_pressed = mushPressed
		texture_focused = mushPressed
	else:
		disabled = true
		texture_hover = dismush
		texture_pressed = dismush
		texture_focused = dismush
	
	pressed.connect(self.mushScene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func mushScene():
	if candleSigil in GVars.sigilData.acquiredSigils:
		SceneHandler.changeSceneToFilePath(SceneHandler.MUSHSPACE)
