extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# L.B: No need for this to happen, text is already "".
	text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# L.B: For better performance, have this happen everytime the number of spins changes.
	# ...Probably through the use of signals.
	# ...Ex: Call a signal when GVars.spin changes.
	text = str(GVars.getScientific(GVars.spin))
