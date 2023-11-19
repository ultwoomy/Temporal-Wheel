extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# L.B: For better performance, have this happen everytime the number of density changes.
	# ...Probably through the use of signals.
	# ...Ex: Call a signal when GVars.density changes.
	text = str(GVars.getScientific(GVars.density))
