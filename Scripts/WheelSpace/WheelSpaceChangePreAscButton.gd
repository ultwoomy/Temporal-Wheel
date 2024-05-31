extends Button


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# L.B: Reminder - the "pressed" function is emitted when button is pressed.
	# ...Copied and pasted from WheelSpaceSpin.gd.
	# ...Probably just use _on_pressed instead; one of its signals.
	pressed.connect(self.changeToPreAsc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#@ Public Methods
func changeToPreAsc():
	if GVars.sigilData.numberOfSigils[2]:
		get_tree().change_scene_to_file("res://Scenes/PreAscSpace.tscn")
