extends AnimatedSprite2D
@export var dia : Label
@export var fear : Button
@export var cold : Button
@export var warmth : Button
@export var wrath : Button
@export var complacent : Button
@export var awaken : Button
@export var challenge : Button
var line
var frames = 0.00
var challNumber = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.curEmotionBuff < 5):
		frame = GVars.curEmotionBuff
	else:
		frame = 0
	_hide_all()
	fear.pressed.connect(self._butF)
	cold.pressed.connect(self._butC)
	warmth.pressed.connect(self._butW)
	wrath.pressed.connect(self._butWrath)
	complacent.pressed.connect(self._butComp)
	awaken.pressed.connect(self._awaken)
	challenge.pressed.connect(self._butCha)
	frames = 0.00
	await get_tree().create_timer(2.5).timeout
	dia.text = "You find yourself\nat an endless ocean."
	GVars._dialouge(dia,0,0.05)
	dia.text += "\n\nIt calls to you."
	dia.text += "\n\nYou feel..."
	await get_tree().create_timer(5).timeout
	if(GVars.sigilData.curSigilBuff == 4):
		fear.show()
		cold.show()
		warmth.show()
		wrath.show()
	if(GVars.sigilData.curSigilBuff == 6):
		if(GVars.curEmotionBuff == 0):
			challenge.show()
			challenge.text = "Incongruent"
			challNumber = 0
		if(GVars.curEmotionBuff == 1):
			challenge.show()
			challenge.text = "Brave"
			challNumber = 1
		if(GVars.curEmotionBuff == 2):
			challenge.show()
			challenge.text = "Sharp"
			challNumber = 2
		if(GVars.curEmotionBuff == 3):
			challenge.text = "Aware"
			challenge.show()
			challNumber = 3
		if(GVars.curEmotionBuff == 4):
			challenge.show()
			challenge.text = "Calm"
			challNumber = 4
	complacent.show()


func _butF():
	_button_generic(1,"feel afraid.\n\nYou try to fly away.\nYou do not escape.")


func _butC():
	_button_generic(2,"feel cold.\n\nYou can't move as water\nCreeps up your limbs\nswallowing you whole.")

func _butW():
	_button_generic(3,"feel warm.\n\nYou willingly embrace the\nwaves.\nYou are crushed.")


func _butWrath():
	_button_generic(4,"feel wrath.\n\nYou strike at the sea\nwith all your might.\nIt's not enough.")


func _butComp():
	_button_generic(0,"feel nothing.\n\nYou sink willingly\ninto the deep.")


func _button_generic(switchEmotion,text):
	_hide_all()
	dia.text = dia.text.left(dia.text.length() - 7)
	frames = 301
	frame = 5
	dia.text += text
	GVars._dialouge(dia,62,0.05)
	await get_tree().create_timer(5).timeout
	if(switchEmotion == 99):
		GVars.hellChallengeNerf = challNumber
		GVars.inContract = true
		switchEmotion = 0
	GVars.curEmotionBuff = switchEmotion
	awaken.show()


func _butCha():
	if(challNumber == 0):
		_button_generic(99,"feel incongruent.\n\nYou've made a terrible mistake.\nIt will be different this time.")
	elif(challNumber == 1):
		_button_generic(99,"feel brave.\n\nYou are ready to go back.\nIt will be different this time.")
	elif(challNumber == 2):
		_button_generic(99,"feel sharp.\n\nAs if hundreds of needles\nare poking your skin.\nIt will be different this time.")
	elif(challNumber == 3):
		_button_generic(99,"feel aware.\n\nAs if you've snapped out\na tired trance.\nIt will be different this time.")
	elif(challNumber == 4):
		_button_generic(99,"feel calm.\n\nYou shove your way through\nthe deep.\nIt will be different this time.")
	else:
		_button_generic(99,"Not good.\n\nError in the code.\nAbort, abort.")

func _awaken():
	GVars.Aspinbuff = GVars.mushroomData.ascBuff + GVars.ritualData.ascBuff  # TODO: Replace this with a global variable in Buffs.gd
	var event_manager: EventManager = get_tree().get_root().find_child("EventManager", true, false)
	if (event_manager):
		event_manager.reset_automators.emit()
	GVars.resetR0Stats()
	if(GVars.ifsecondboot == 0):
		GVars.ifsecondboot = 1
	if(GVars.ifsecondboot == 2):
		GVars.ifsecondboot = 3
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")


func _hide_all():
	fear.hide()
	cold.hide()
	warmth.hide()
	wrath.hide()
	complacent.hide()
	awaken.hide()
	challenge.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(frames < 200):
		frames += 1
		modulate = Color(frames/200,frames/200,frames/200)
	if(frames > 300) and (frames < 2400):
		frames += 1
		scale = Vector2(float(frames)/300,float(frames)/300)
