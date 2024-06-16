extends Label


#@ Virtual Method
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# L.B: For better performance, have this happen everytime the number of rotations changes.
	# ...Probably through the use of signals.
	# ...Ex: Call a signal when GVars.rotations changes.
	if GVars.hellChallengeLayer2 == 0 and GVars.spinData.rotations > 100:
		text = "The sands of time erode your wheel\n" + str("Rotations: ",GVars.getScientific(GVars.spinData.rotations))
	else:
		text = str("Rotations: ",GVars.getScientific(GVars.spinData.rotations))
