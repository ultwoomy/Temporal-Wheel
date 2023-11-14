extends Node
@export var growDisplay: Label
@export var button : Button
@export var image : Sprite2D
var ifsucc = false
func _ready():
	suc_loop()
	button.text = str("Toggle Condense")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.density)
	button.pressed.connect(self._button_pressed)
	image.scale.x = GVars.curSucDens/GVars.densTresh*2

func _button_pressed():
	if(ifsucc):
		ifsucc = false
		image.set_texture(load("res://Sprites/WheelSpace/redrect.png"))
	else :
		ifsucc = true
		image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
	GVars.save_prog()
	
func suc_loop():
	if(ifsucc):
		if(GVars.size > GVars.sucPerTDens):
			GVars.size -= GVars.sucPerTDens
			GVars.curSucDens += GVars.sucPerTDens
			if(GVars.curSucDens >= GVars.densTresh):
				GVars.density += 1
				growDisplay.text = str(GVars.density)
				GVars.curSucDens = 0
				GVars.sucPerTDens *= 2
				GVars.densTresh *= 2
				GVars.wheelphase = int(GVars.density)
	image.scale.x = GVars.curSucDens/GVars.densTresh*2
	await get_tree().create_timer(2.0).timeout
	suc_loop()
	

