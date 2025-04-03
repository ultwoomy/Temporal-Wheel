extends Container


#@ Signals
signal kbity_up


#@ Export Variables


#@ Public Variables
var line = 0


#@ Onready Variables
@onready var dialogueBox : Label = $DialougeBox
@onready var nextButton : Button = $NextButton


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Only shows the dialouge box if its the players first time coming here
	if GVars.ifFirstVoid:
		get_tree().paused = true
		show()
	else:
		hide()
	
	dialogueBox.position = Vector2(300,300)
	dialogueBox.text = "Welcome to the bus stop!"
	dialogueBox.size = Vector2(400,200)
	
	nextButton.size = Vector2(100,100)
	nextButton.position = Vector2(650,400)
	nextButton.text = "Next"
	nextButton.expand_icon = true
	nextButton.pressed.connect(self._buttonPressed)
	
	GVars._dialouge(dialogueBox,0,0.02)
	self.kbity_up.connect(self.kbityTime)


#@ Public Methods
# L.B: Don't know what to do with this quite yet.
func kbityTime():
	if(GVars.kbityData.kbityLevel == 1):
		get_tree().paused = true
		line = 10
		show()


#@ Private Methods
func _buttonPressed():
	GVars._dialouge(dialogueBox,0,0.03)
	# too short for me to make it an array or anything better than a series of if statements tbh
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
