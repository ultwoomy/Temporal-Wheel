extends Node
@export var packback : AnimatedSprite2D
@export var sigilDisplay : AnimatedSprite2D
@export var next : Button
@export var back : Button
@export var text : Label
@export var menu : Container
var line = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	packback.frame = 2
	next.size = Vector2(100,100)
	next.position = Vector2(355,410)
	next.text = "Next"
	next.pressed.connect(self.button_pressed)
	back.pressed.connect(self.back_button_pressed)
	next.hide()
	menu.hide()
	if(GVars.curSigilBuff != 0):
		sigilDisplay.frame = GVars.curSigilBuff - 1
		sigilDisplay.show()
	else:
		sigilDisplay.frame = 0
		sigilDisplay.hide()
	if(GVars.iffirstpack):
		packback.frame = 1
		text.text = "We're Closed."
		GVars._dialouge(text,0,0.04)
		if(GVars.numberOfSigils > 0):
			next.show()
			next.text = "Perhaps this will\nchange your mind"
	else:
		menu.show()

func button_pressed():
	GVars._dialouge(text,0,0.04)
	if(line == 0):
		text.text = "Huh. Where'd you even get \nthat hammer sigil?"
		packback.frame = 0
		next.text = "Next"
		next.position = Vector2(355,410)
		line += 1
	elif(line== 1):
		packback.frame = 2
		text.text = "Forget it. Since you have my \nsigil I guess I'll offer my \nservices."
		next.text = "What\nservices?"
		line += 1
	elif(line == 2):
		text.text = "Blacksmithing. I specialize in \nsigils though. I'll be able\ngive you a little background\non them."
		next.text = "Next"
		line += 1
	elif(line == 3):
		text.text = "I know a bit of strengthening\ntoo, so I can give you buffs\nto your production."
		line += 1
	elif(line == 4):
		text.text = "Lastly, rust is a currency.\nEven though I live in a place\nsurrounded by rust, I can't\nleave this room."
		packback.frame = 3
		line += 1
	elif(line == 5):
		text.text = "The irony is cruel."
		packback.frame = 2
		line += 1
	elif(line == 6):
		text.text = "Bring me some and I'll buff\nsome more things."
		line += 1
	elif(line == 7):
		text.text = "Be careful though, rust drops\nmore and more infrequently\nas time goes on"
		line += 1
		GVars.iffirstpack = false
	elif(line == 4):
		text.text = ""
		menu.show()
		next.hide()
		

func back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/RustSpaceOutside.tscn")
