extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.sigilData.numberOfSigils[4]):
		show()
	else:
		hide()
	size = Vector2(100,100)
	position = Vector2(370,410)
	text = "Ritual"
	pressed.connect(self.sendopensignal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func sendopensignal(): 
	get_parent().get_node("TutorialBox").openRitual()
