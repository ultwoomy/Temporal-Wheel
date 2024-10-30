extends TextureButton


#@ Public Variable
var dismush = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile002.png")


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	const candleSigil : Sigil = preload("res://Resources/Sigil/CandleSigil.tres")
	if candleSigil in GVars.sigilData.acquiredSigils:
		disabled = false
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
	SceneHandler.changeSceneToFilePath(SceneHandler.MUSHSPACE)
