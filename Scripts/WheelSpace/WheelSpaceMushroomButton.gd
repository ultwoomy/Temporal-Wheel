extends TextureButton
var dismush = preload("res://Sprites/WheelSpace/mush_ext_sheet/tile002.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# L.B: Odd how numberOfSigils does not tell us that the player needs the candle sigil.
	# ...This actually means that if you have two non-candle sigils, this would be valid.
	# ...Perhaps an object with booleans would be better?
	if(GVars.numberOfSigils > 1):
		disabled = false
	else:
		disabled = true
		texture_hover = dismush
		texture_pressed = dismush
		texture_focused = dismush
	# L.B: Reminder - the "pressed" function is emitted when button is pressed.
	# ...Copied and pasted from WheelSpaceSpin.gd.
	# ...Probably just use _on_pressed instead; one of its signals.
	pressed.connect(self._mush_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# L.B: Odd how inconsistent the function names are for changing scenes.
# ...Usually, "_" prefixes mean that this function should get overwritten by its inheriters.
func _mush_scene():
	get_tree().change_scene_to_file("res://Scenes/MushSpace.tscn")