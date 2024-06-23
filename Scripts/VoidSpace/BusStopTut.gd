extends Container


#@ Signals
signal kbity_up


#@ Export Variables
@export var sigilbut : Button  # SigilZone
@export var ritualEnter : Button  # RitualZone
@export var busstop : Sprite2D  # BusStop
@export var goback : Button  # BackButton
@export var sigilshop : Container  # SigilShop
@export var ritualShop : Container  # RitualShop


#@ Public Variables
var layersin = 0
var line = 0


#@ Onready Variables
@onready var dialogueBox : Label = $DialougeBox
@onready var nextButton : Button = $NextButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# COMPLETED IN VoidSpaceMenuPickState.gd
	sigilshop.hide()
	
	# Only shows the dialouge box if its the players first time coming here
	if GVars.ifFirstVoid:
		get_tree().paused = true
		show()
	else :
		hide()
	
	dialogueBox.position = Vector2(300,300)
	dialogueBox.text = "Welcome to the bus stop!"
	dialogueBox.size = Vector2(400,200)
	
	nextButton.size = Vector2(100,100)
	nextButton.position = Vector2(650,400)
	nextButton.text = "Next"
	nextButton.expand_icon = true
	nextButton.pressed.connect(self._buttonPressed)
	
#	sigilbut.size = Vector2(100,100)
#	sigilbut.position = Vector2(300,200)
#	sigilbut.text = "Sigil"
#	sigilbut.pressed.connect(self.openSigilShop)
	
#	goback.pressed.connect(self._goBack)
	GVars._dialouge(dialogueBox,0,0.02)
	self.kbity_up.connect(self.kbityTime)


#@ Public Methods
# COMPLETED IN VoidSpaceMenuSigilState.gd
func openSigilShop():
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


#@ Private Methods
'
func _goBack():
	#checks where the back button is supposed to send the player
	#layersin represents whether the player has opened up one of the functions
	#	L.B: "one of the functions" means opening up another menu like the shop or ritual.
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
		# COMPLETED IN VoidSpaceMenuState.gd
		SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)
'


func _buttonPressed():
	GVars._dialouge(dialogueBox,0,0.03)
	#too short for me to make it an array or anything better than a series of if statements tbh
	if(line == 0):
		self.get_node("Bunnies").frame = 2
		dialogueBox.text = "This is where the business \nhappens."
	elif(line == 1):
		self.get_node("Bunnies").frame = 1
		dialogueBox.text = "You give me rotations, I give \nyou a cool lookin circle\ncalled a sigil."
	elif(line == 2):
		self.get_node("Bunnies").frame = 0
		dialogueBox.text = "And then other stuff too \nprobably."
	elif(line == 3):
		dialogueBox.text = "Later."
	elif(line == 4):
		self.get_node("Bunnies").frame = 1
		dialogueBox.text = "But I need those so come to\nme every time you have enough\nto trade, yes?"
	elif(line == 10):
		self.get_node("Bunnies").frame = 3
		dialogueBox.text = "You... I can't believe you actually did it."
	elif(line == 11):
		self.get_node("Bunnies").frame = 3
		dialogueBox.text = "You've created another kbity cat. How's time supposed to function now?"
	elif(line == 12):
		self.get_node("Bunnies").frame = 1
		dialogueBox.text = "I mean yeah I was the one who helped you do it but the prices were absurd on purpose."
	elif(line == 13):
		self.get_node("Bunnies").frame = 1
		dialogueBox.text = "It's probably fine though. It doesn't have a soul or a part of a soul like you and me."
	elif(line == 14):
		self.get_node("Bunnies").frame = 2
		dialogueBox.text = "Maybe you'll get more time every time you get time? Won't that be fun!"
	elif(line == 15):
		self.get_node("Bunnies").frame = 2
		dialogueBox.text = "And it'll never go away so no need to worry about losing it upon resetting."
	else:
		hide()
		GVars.ifFirstVoid = false
		get_tree().paused = false
	line += 1
