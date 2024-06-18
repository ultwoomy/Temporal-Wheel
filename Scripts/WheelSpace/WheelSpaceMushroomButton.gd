extends TextureButton


#@ Public Variable
var dismush = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile002.png")


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GVars.sigilData.numberOfSigils:
		if GVars.sigilData.numberOfSigils[1]:
			disabled = false
	else:
		disabled = true
		texture_hover = dismush
		texture_pressed = dismush
		texture_focused = dismush
	# L.B: Reminder - the "pressed" function is emitted when button is pressed.
	# ...Copied and pasted from WheelSpaceSpin.gd.
	# ...Probably just use _on_pressed instead; one of its signals.
	pressed.connect(self.mushScene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func mushScene():
	SceneHandler.changeSceneToFilePath(SceneHandler.MUSHSPACE)
