extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	if Automation.contains("Mushbot"):
		show()
	else:
		hide()
