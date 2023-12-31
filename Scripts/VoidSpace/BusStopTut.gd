extends Container
@export var text : Label
@export var button : Button
@export var sigilbut : Button
@export var ritualEnter : Button
@export var busstop : Sprite2D
@export var goback : Button
@export var sigilshop : Container
@export var ritualShop : Container
var layersin = 0
var line = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	sigilshop.hide()
	if(GVars.iffirstvoid):
		get_tree().paused = true
		show()
	else :
		hide()
	text.position = Vector2(300,300)
	text.text = "Welcome to the bus stop!"
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
	
func _go_back():
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
	ritualShop.hide()
	sigilshop.show()
	
func openRitual():
	busstop.set_texture(load("res://Sprites/VoidSpace/bunny_zoom_2.png"))
	busstop.scale = Vector2(6,6)
	busstop.position = Vector2(400,230)
	layersin = 1
	sigilbut.hide()
	ritualEnter.hide()
	sigilshop.hide()
	ritualShop.show()
