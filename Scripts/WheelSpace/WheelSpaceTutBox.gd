extends Node
@export var text : Label
@export var button : Button
@export var tutScreen : Container

var line = 0
var firstmessage = true
var bunscript = ["Welcome to your new job!",
				 "Here's a quick breakdown!",
				 "The spin button increases this \nwheel's momentum.",
				 "The grow button consumes \nmomentum every spin, eventually \nincreasing the size of the wheel.",
				 "The condense button consumes \nsize every time you click,\nreducing it's size but\nincreasing it's spin speed.",
				 "Both of these multiply your \nmomentum per spin, so don't\nsoftlock yourself by\ncondensing too much.",
				 "But that's it! It's a very\n easy job!",
				 "Come visit the void whenever\nyou feel comfy.",
				 "Buh bye!",
				
				 "Oh! It's you!",
				 "You didn't show up so I thought\nyou died.",
				 "So I threw out like.",
				 "All your things.",
				 "Like into a big hole.",
				 "You don't mind right?",
				 "I also took back all the sigils.",
				 "Buh bye!"]
				
var bunspritelist = [2,0,1,1,1,3,2,0,2,
					 2,1,2,0,0,2,0,2]
var whenend = [false,false,false,false,false,false,false,false,true,
			   false,false,false,false,false,false,false,true]
			
func nextLine():
	line += 1
	text.text = bunscript[line]
	self.get_node("Bunnies").frame = bunspritelist[line]
	firstmessage = false
# Called when the node enters the scene tree for the first time.
func _ready():
	firstmessage = true
	if(GVars.iffirstboot):
		get_tree().paused = true
		tutScreen.show()
	elif(GVars.ifsecondboot == 1):
		get_tree().paused = true
		tutScreen.show()
	else :
		tutScreen.hide()
	text.position = Vector2(300,300)
	text.text = "Hellos!"
	GVars._dialouge(text,0,0.02)
	button.size = Vector2(100,100)
	button.position = Vector2(650,400)
	button.text = "Next"
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)

func _button_pressed():
	GVars._dialouge(text,0,0.02)
	if(whenend[line]) and (GVars.iffirstboot):
		tutScreen.hide()
		GVars.iffirstboot = false
		get_tree().paused = false
	elif(whenend[line]) and (GVars.ifsecondboot == 1):
		tutScreen.hide()
		GVars.ifsecondboot = 2
		get_tree().paused = false
	elif GVars.iffirstboot and firstmessage:
		line = -1
		nextLine()
	elif GVars.ifsecondboot == 1 and firstmessage:
		line = 8
		nextLine()
	else:
		nextLine()
