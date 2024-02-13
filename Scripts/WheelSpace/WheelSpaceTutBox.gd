extends Node
@export var text : Label
@export var button : Button
@export var tutScreen : Container

var line = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.iffirstboot):
		get_tree().paused = true
		tutScreen.show()
	elif(GVars.ifsecondboot):
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _button_pressed():
	GVars._dialouge(text,0,0.02)
	if(line == 0):
		self.get_node("Bunnies").frame = 2
		text.text = "Welcome to your new job!"
	elif(line == 1):
		self.get_node("Bunnies").frame = 0
		text.text = "Here's a quick breakdown!"
	elif(line == 2):
		self.get_node("Bunnies").frame = 1
		text.text = "The spin button increases this \nwheel's momentum."
	elif(line == 3):
		text.text = "The grow button consumes \nmomentum every spin, eventually \nincreasing the size of the wheel."
	elif(line == 4):
		text.text = "The condense button consumes \nsize every time you click,\nreducing it's size but\nincreasing it's spin speed."
	elif(line == 5):
		self.get_node("Bunnies").frame = 3
		text.text = "Both of these multiply your \nmomentum per spin, so don't\nsoftlock yourself by\ncondensing too much."
	elif(line == 6):
		self.get_node("Bunnies").frame = 2
		text.text = "But that's it! It's a very\n easy job!"
	elif(line == 7):
		self.get_node("Bunnies").frame = 0
		text.text = "Come visit the void whenever\nyou feel comfy."
	elif(line == 8):
		self.get_node("Bunnies").frame = 2
		text.text = "Buh bye!"
	else:
		tutScreen.hide()
		GVars.iffirstboot = false
		get_tree().paused = false
	line += 1
