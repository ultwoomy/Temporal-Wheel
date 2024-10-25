extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# L.B: For better performance, have this happen everytime the number of size changes.
	# ...Probably through the use of signals.
	# ...Ex: Call a signal when GVars.size changes.
	if GVars.hasChallenge(GVars.CHALLENGE_SHARP):
		text = str(GVars.getScientific(GVars.spinData.size)) + "^0.5/" + str(GVars.getScientific(log(GVars.spinData.rotations + 2)/2))
	elif GVars.curEmotionBuff == 2:
		text = str(GVars.getScientific(GVars.spinData.size)) + "^" + str(GVars.spinData.density + 1)
	else:
		text = str(GVars.getScientific(GVars.spinData.size))
