extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# L.B: Reminder - the "pressed" function is emitted when button is pressed.
	# ...Copied and pasted from WheelSpaceSpin.gd.
	# ...Probably just use _on_pressed instead; one of its signals.
	pressed.connect(self._changetopreasc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# L.B: Odd how inconsistent the function names are for changing scenes.
# ...Usually, "_" prefixes mean that this function should get overwritten by its inheriters.
func _changetopreasc():
	if(GVars.numberOfSigils > 2):
		get_tree().change_scene_to_file("res://Scenes/PreAscSpace.tscn")
