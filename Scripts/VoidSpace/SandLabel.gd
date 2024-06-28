extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	if not GVars.hellChallengeLayer2 == 0:
		hide()
	else:
		show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Sand amount: " + str(GVars.sand)
