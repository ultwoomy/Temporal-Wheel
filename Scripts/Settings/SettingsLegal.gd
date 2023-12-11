extends Container
@export var license : Label
@export var back : Sprite2D
@export var licensebutton : Button
func _ready():
	licensebutton.text = "License"
	size = Vector2(200,100)
	licensebutton.pressed.connect(self._button_pressed)
	back.hide()
	license.hide()
	license.text = "\n\n\n\n" + Engine.get_license_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed():
	back.show()
	license.show()
