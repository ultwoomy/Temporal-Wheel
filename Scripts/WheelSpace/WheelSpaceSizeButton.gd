extends Node
@export var growDisplay: Label
@export var button : Button
@export var image : Sprite2D
var ifsucc = false
func _ready():
	suc_loop()
	button.text = str("Toggle Grow")
	button.size = Vector2(200,100)
	button.expand_icon = true
	growDisplay.text = str(GVars.size)
	button.pressed.connect(self._button_pressed)
	image.scale.x = GVars.curSucSize/GVars.sucTresh*2

func _button_pressed():
	if(ifsucc):
		ifsucc = false
		image.set_texture(load("res://Sprites/WheelSpace/redrect.png"))
	else :
		ifsucc = true
		image.set_texture(load("res://Sprites/WheelSpace/greenrect.png"))
	GVars.save_prog()
	
func suc_loop():
	var suc = 0.0;
	if(GVars.curSigilBuff == 3):
		suc = GVars.sucPerTick * GVars.Rincreasehunger * GVars.size
	else:
		suc = GVars.sucPerTick * GVars.Rincreasehunger
	if(ifsucc):
		if(GVars.spin >= suc):
			GVars.spin -= suc
			GVars.curSucSize += suc
			if(GVars.curSucSize >= GVars.sucTresh):
				GVars.size += 1
				growDisplay.text = str(GVars.size)
				GVars.curSucSize = 0
				GVars.sucTresh *= 5
	image.scale.x = GVars.curSucSize/GVars.sucTresh*2
	await get_tree().create_timer(1.0).timeout
	suc_loop()
