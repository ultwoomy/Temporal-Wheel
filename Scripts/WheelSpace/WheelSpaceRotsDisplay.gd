extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# L.B: For better performance, have this happen everytime the number of rotations changes.
	# ...Probably through the use of signals.
	# ...Ex: Call a signal when GVars.rotations changes.
	text = str("Rotations: ",GVars.getScientific(GVars.rotations))
