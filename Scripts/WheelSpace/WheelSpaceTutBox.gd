extends Node


#@ Export Variables
@export var text : Label
@export var button : Button
@export var tutScreen : Container


#@ Public Variables
var line = 0
var firstmessage = true
var bunscript = ["Welcome to your new job!",
				 "Here's a quick breakdown!",
				 "The spin button increases this \nwheel's momentum.",
				 "The grow button consumes \nmomentum every spin, eventually \nincreasing the size of the wheel.",
				 "The condense button consumes \nsize every time you click,\nreducing it's size but\nincreasing it's spin speed.",
				 "Both of these multiply your \nmomentum per spin, so don't\nsoftlock yourself by\ncondensing too much.",
				 "But that's like it! It's a very\n easy job!",
				 "Come visit the void whenever\nyou feel comfy.",
				 "Buh bye!",
				
				 "Oh! It's you!",
				 "You didn't show up so I thought\nyou died.",
				 "So I threw out like.",
				 "All your things.",
				 "Like into a big hole.",
				 "You don't mind right?",
				 "I also took back all the sigils.",
				 "Buh bye!",
				
				 "Welcome back!",
				 "Funny story about all your stuff.",
				 "When you got absorbed by your\nwheel this like huge bird.",
				 "Came by and swept up like all\nyour stuff it was crazy.",
				 "I saved your sigils from it by\ntaking them back.",
				 "No need to thank me.",
				 "Buh bye!",
				
				 "Something crazy just happened.",
				 "There was this big bad worlf\nwho said something like",
				 "Yargh! This schumks booty\nbe mine now!",
				 "But like with a less\ninteresting accent.",
				 "I bartered for your sigils\nback by offering your\nmushroom farm as collateral.",
				 "Buy them back anytime.",
				 "Buh bye!",
				
				 "Funny story.",
				 "So there was this giant nasty looking pillar of eyes and other stuff.",
				 "And it swept by the area absorbing all your stuff.",
				 "Giggling to itself the entire time.",
				 "Kinda rude right?",
				 "Don't worry, I saved the sigils like always.",
				 "See you when you come by to buy them!",
				 "Buh bye!",
				
				 "Sooooooooo.",
				 "Nothing actually happened to your things this time.",
				 "I still took the sigils and everything else.",
				 "I have no excuse.",
				 "I feel terrible about this and am reflecting on my actions.",
				 "I'm not giving them back though.",
				 "Buh bye!",]
				
var bunspritelist = [2,0,1,1,1,3,2,0,2,
					 2,1,2,0,0,2,0,2,
					 2,1,0,3,0,0,2,
					 3,1,3,0,2,0,2,
					 2,0,0,0,1,2,1,2,
					 0,0,0,0,0,0,2]
var whenend = [false,false,false,false,false,false,false,false,true,
			   false,false,false,false,false,false,false,true,
			   false,false,false,false,false,false,true,
			   false,false,false,false,false,false,true,
			   false,false,false,false,false,false,false,true,
			   false,false,false,false,false,false,true]


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	if GVars.ifSecondBoot > 9 and GVars.ifSecondBoot % 2 == 1:
		GVars.ifSecondBoot += 1
	firstmessage = true
	if (GVars.ifFirstBoot or GVars.ifSecondBoot % 2 == 1) and GVars.ifSecondBoot <= 9:
		get_tree().paused = true
		tutScreen.show()
	else :
		tutScreen.hide()
	text.position = Vector2(300,300)
	text.size = Vector2(400,300)
	text.text = "Hellos!"
	GVars._dialouge(text,0,0.02)
	button.size = Vector2(100,100)
	button.position = Vector2(650,400)
	button.text = "Next"
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)


#@ Public Methods
func nextLine():
	line += 1
	text.text = bunscript[line]
	self.get_node("Bunnies").frame = bunspritelist[line]
	firstmessage = false


#@ Private Methods
func _button_pressed():
	GVars._dialouge(text,0,0.02)
	if(whenend[line]) and (GVars.ifFirstBoot):
		tutScreen.hide()
		GVars.ifFirstBoot = false
		get_tree().paused = false
	elif whenend[line] and GVars.ifSecondBoot % 2 == 1:
		tutScreen.hide()
		GVars.ifSecondBoot += 1
		get_tree().paused = false
	elif GVars.ifFirstBoot and firstmessage:
		line = -1
		nextLine()
	elif GVars.ifSecondBoot == 1 and firstmessage:
		line = 8
		nextLine()
	elif GVars.ifSecondBoot == 3 and firstmessage:
		line = 16
		nextLine()
	elif GVars.ifSecondBoot == 5 and firstmessage:
		line = 23
		nextLine()
	elif GVars.ifSecondBoot == 7 and firstmessage:
		line = 30
		nextLine()
	elif GVars.ifSecondBoot == 9 and firstmessage:
		line = 38
		nextLine()
	else:
		nextLine()
