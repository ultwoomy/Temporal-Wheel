extends Button
func _ready():
	text = "Save"
	size = Vector2(200,100)
	pressed.connect(self._button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed():
	GVars.save_prog()
