extends AnimatedSprite2D
@export var dia : Label
@export var fear : Button
@export var cold : Button
@export var warmth : Button
@export var wrath : Button
@export var complacent : Button
@export var awaken : Button
var line
var frames = 0.00
# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.curEmotionBuff < 5):
		frame = GVars.curEmotionBuff
	elif(GVars.sigilData.curSigilBuff == 6):
		frame = 6
	else:
		frame = 0
	_hide_all()
	fear.pressed.connect(self._butF)
	cold.pressed.connect(self._butC)
	warmth.pressed.connect(self._butW)
	wrath.pressed.connect(self._butWrath)
	complacent.pressed.connect(self._butComp)
	awaken.pressed.connect(self._awaken)
	frames = 0.00
	await get_tree().create_timer(2.5).timeout
	if(GVars.sigilData.curSigilBuff == 6) and !GVars.ifhell:
		dia.text = "The waves reach up\nto catch you."
		GVars._dialouge(dia,0,0.05)
		dia.text += "\n\nYou feel yourself\nslipping away"
		await get_tree().create_timer(5).timeout
		awaken.show()
	else:
		dia.text = "You find yourself\nat an endless ocean."
		GVars._dialouge(dia,0,0.05)
		dia.text += "\n\nIt calls to you."
		dia.text += "\n\nYou feel..."
		await get_tree().create_timer(5).timeout
		if(GVars.sigilData.curSigilBuff == 4):
			if(GVars.hellChallengeNerf != 1):
				fear.show()
			if(GVars.hellChallengeNerf != 2):
				cold.show()
			if(GVars.hellChallengeNerf != 3):
				warmth.show()
			if(GVars.hellChallengeNerf != 4):
				wrath.show()
		complacent.show()

func _butF():
	_button_generic(1,"feel afraid.\n\nYou try to fly away.\nYou do not escape.")
	
func _butC():
	_button_generic(2,"feel cold.\n\nYou can't move as\nwater creeps up your\nlimbs, swallowing you.")

func _butW():
	_button_generic(3,"feel warm.\n\nYou willingly embrace\nthe waves.\nYou are crushed.")
	
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
	GVars.curEmotionBuff = switchEmotion
	awaken.show()

func _awaken():
	if(GVars.sigilData.curSigilBuff == 6) and !GVars.ifhell:
		GVars.resetR0Stats()
		GVars.hellChallengeNerf = GVars.curEmotionBuff
		GVars.resetR1Stats()
		get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
	elif(GVars.mushroomData.ascBuff + GVars.ritualData.ascBuff > GVars.Aspinbuff):
		GVars.Aspinbuff = GVars.mushroomData.ascBuff + GVars.ritualData.ascBuff
	var event_manager: EventManager = get_tree().get_root().find_child("EventManager", true, false)
	if (event_manager):
		event_manager.reset_automators.emit()
	GVars.resetR0Stats()
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")
	
func _hide_all():
	fear.hide()
	cold.hide()
	warmth.hide()
	wrath.hide()
	complacent.hide()
	awaken.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(frames < 200):
		frames += 1
		modulate = Color(frames/200,frames/200,frames/200)
	if(frames > 300) and (frames < 2400):
		frames += 1
		scale = Vector2(float(frames)/300,float(frames)/300)
