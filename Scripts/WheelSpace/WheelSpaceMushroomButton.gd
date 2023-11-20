extends TextureButton
var dismush = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile002.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(GVars.numberOfSigils[1]):
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


# L.B: Odd how inconsistent the function names are for changing scenes.
# ...Usually, "_" prefixes mean that this function should get overwritten by its inheriters.
#YU: Naming convention inconsistent, probably will fix slowly
func mushScene():
	get_tree().change_scene_to_file("res://Scenes/MushSpace.tscn")
