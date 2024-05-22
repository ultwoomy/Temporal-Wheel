extends Container
@export var text : Label
@export var button : Button
@export var sigilbut : Button
@export var ritualEnter : Button
@export var busstop : Sprite2D
@export var goback : Button
@export var sigilshop : Container
@export var ritualShop : Container
signal kbity_up
var layersin = 0
var line = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	sigilshop.hide()
	if(GVars.iffirstvoid):
		#only shows the dialouge box if its the players first time coming here
		get_tree().paused = true
		show()
	else :
		hide()
	text.position = Vector2(300,300)
	text.text = "Welcome to the bus stop!"
	text.size = Vector2(400,200)
	button.size = Vector2(100,100)
	button.position = Vector2(650,400)
	button.text = "Next"
	button.expand_icon = true
	button.pressed.connect(self._button_pressed)
	sigilbut.size = Vector2(100,100)
	sigilbut.position = Vector2(300,200)
	sigilbut.text = "Sigil"
	sigilbut.pressed.connect(self.opensigilshop)
	goback.pressed.connect(self._go_back)
	GVars._dialouge(text,0,0.02)
	self.kbity_up.connect(self.kbityTime)
	
func _go_back():
	#checks where the back button is supposed to send the player
	#layersin represents whether the player has opened up one of the functions
	#probably could have been seperate scenes as well, but this is how it works rn
	if(layersin == 1):
		busstop.set_texture(load("res://Sprites/VoidSpace/bus_stop.png"))
		busstop.scale = Vector2(2,2)
		busstop.position = Vector2(500,300)
		layersin = 0
		sigilbut.show()
		sigilshop.hide()
		if(GVars.sigilData.numberOfSigils[4]):
			ritualEnter.show()
			ritualShop.hide()
	else :
		var event_manager = get_tree().get_root().find_child("EventManager", true, false)
		event_manager.emit_signal("scene_change",true)
		get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")

func _button_pressed():
	GVars._dialouge(text,0,0.03)
	#too short for me to make it an array or anything better than a series of if statements tbh
	if(line == 0):
		self.get_node("Bunnies").frame = 2
		text.text = "This is where the business \nhappens."
	elif(line == 1):
		self.get_node("Bunnies").frame = 1
		text.text = "You give me rotations, I give \nyou a cool lookin circle\ncalled a sigil."
	elif(line == 2):
		self.get_node("Bunnies").frame = 0
		text.text = "And then other stuff too \nprobably."
	elif(line == 3):
		text.text = "Later."
	elif(line == 4):
		self.get_node("Bunnies").frame = 1
		text.text = "But I need those so come to\nme every time you have enough\nto trade, yes?"
	elif(line == 10):
		self.get_node("Bunnies").frame = 3
		text.text = "You... I can't believe you actually did it."
	elif(line == 11):
		self.get_node("Bunnies").frame = 3
		text.text = "You've created another kbity cat. How's time supposed to function now?"
	elif(line == 12):
		self.get_node("Bunnies").frame = 1
		text.text = "I mean yeah I was the one who helped you do it but the prices were absurd on purpose."
	elif(line == 13):
		self.get_node("Bunnies").frame = 1
		text.text = "It's probably fine though. It doesn't have a soul or a part of a soul like you and me."
	elif(line == 14):
		self.get_node("Bunnies").frame = 2
		text.text = "Maybe you'll get more time every time you get time? Won't that be fun!"
	elif(line == 15):
		self.get_node("Bunnies").frame = 2
		text.text = "And it'll never go away so no need to worry about losing it upon resetting."
	else:
		hide()
		GVars.iffirstvoid = false
		get_tree().paused = false
	line += 1
	
func opensigilshop():
	busstop.set_texture(load("res://Sprites/VoidSpace/sigil_bunny_zoom.png"))
	busstop.scale = Vector2(5,5)
	busstop.position = Vector2(600,250)
	layersin = 1
	sigilbut.hide()
	ritualEnter.hide()
	sigilshop.show()
	ritualShop.hide()
	
func openRitual():
	busstop.set_texture(load("res://Sprites/VoidSpace/bunny_zoom_2.png"))
	busstop.scale = Vector2(6,6)
	busstop.position = Vector2(400,230)
	layersin = 1
	sigilbut.hide()
	ritualEnter.hide()
	sigilshop.hide()
	ritualShop.show()
	
func kbityTime():
	if(GVars.kbityData.kbityLevel == 1):
		get_tree().paused = true
		line = 10
		show()
