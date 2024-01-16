extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Quit"
	size = Vector2(200,100)
	pressed.connect(self._wheel_scene)
	
func _wheel_scene():
	GVars.save_prog()
	get_tree().quit()
