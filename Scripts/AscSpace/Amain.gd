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
	#Changes background depending on current emote, irrespective of challenge
	#TODO: Add changes depending on challenge
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
	#If face is active, show emotion
	#Cannot stack emotion with challenge of the same type
	if(GVars.sigilData.curSigilBuff == 3):
		if!(GVars.hellChallengeNerf == 0):
			fear.show()
		if!(GVars.hellChallengeNerf == 1):
			cold.show()
		if!(GVars.hellChallengeNerf == 2):
			warmth.show()
		if!(GVars.hellChallengeNerf == 3):
			wrath.show()
	#If hell sigil is active and hell is not unlocked, show challenge options based on emote buff
	#Nothing prepared for no emote buff, shouldn't be easy or possible to get
	if(GVars.sigilData.curSigilBuff == 5) and (!GVars.ifhell):
		if(GVars.curEmotionBuff <= 0):
			challenge.show()
			challenge.text = "Incongruent"
			challNumber = 0
		elif(GVars.curEmotionBuff == 1):
			challenge.show()
			challenge.text = "Brave"
			challNumber = 1
		elif(GVars.curEmotionBuff == 2):
			challenge.show()
			challenge.text = "Sharp"
			challNumber = 2
		elif(GVars.curEmotionBuff == 3):
			challenge.text = "Aware"
			challenge.show()
			challNumber = 3
		elif(GVars.curEmotionBuff == 4):
			challenge.show()
			challenge.text = "Calm"
			challNumber = 4
	#If a second layer challenge is activated and there is no first layer challenge
	#Show the unfinished meme challenges
	#Does not actually start them until until exiting screen, is currently abusable by exiting the game during this cutscene
	if(GVars.hellChallengeLayer2 == 0) and GVars.hellChallengeNerf < 0 and GVars.hellChallengeInit:
		challenge.show()
		challenge.text = "Sandy"
		GVars.hellChallengeInit = false
		challNumber = 10
	elif(GVars.hellChallengeLayer2 == 1) and GVars.hellChallengeNerf < 0 and GVars.hellChallengeInit:
		challenge.show()
		challenge.text = "Bittersweet"
		GVars.hellChallengeInit = false
		challNumber = 11
	elif(GVars.hellChallengeLayer2 == 2) and GVars.hellChallengeNerf < 0 and GVars.hellChallengeInit:
		challenge.show()
		challenge.text = "Starved"
		GVars.hellChallengeInit = false
		challNumber = 12
	elif(GVars.hellChallengeLayer2 == 3) and GVars.hellChallengeNerf < 0 and GVars.hellChallengeInit:
		challenge.show()
		challenge.text = "Fabulous"
		GVars.hellChallengeInit = false
		challNumber = 13
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
	#99 is placeholder number for layer 1 challenge, 199 for layer 2
	if(switchEmotion == 99):
		GVars.hellChallengeNerf = challNumber
		GVars.inContract = true
		switchEmotion = 0
		GVars.curEmotionBuff = 0
	elif(switchEmotion == 199):
		GVars.hellChallengeLayer2 = challNumber - 10
		GVars.inContract = true
		GVars.hellChallengeInit = true
		switchEmotion = 0
	else:
		GVars.curEmotionBuff = switchEmotion
	awaken.show()

func _butCha():
	#numbers 0 - 4 are for layer 1 challenges
	#numbers 10 - 13 are for layer 2 challenges
	#kinda awkward that in the case of something breaking it basically resets the game
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
	elif(challNumber == 10):
		_button_generic(199,"feel sandy.\n\nIt's course and gritty and\ngets everywhere.")
	elif(challNumber == 11):
		_button_generic(199,"feel bittersweet.\n\nThe world is so beautiful\nyou want to cry.")
	elif(challNumber == 12):
		_button_generic(199,"feel starved.\n\nIt's eating you up on the\ninside.")
	elif(challNumber == 13):
		_button_generic(199,"feel fabulous.\n\nIt's time to slay, in one\nway or another.")
	else:
		_button_generic(199,"Not good.\n\nError in the code.\nContinuing will half\nreset your save.")

func _awaken():
	GVars.Aspinbuff = GVars.mushroomData.ascBuff + GVars.ritualData.ascBuff
	var event_manager: EventManager = get_tree().get_root().find_child("EventManager", true, false)
	if (event_manager):
		event_manager.reset_automators.emit()
	GVars.resetR0Stats()
	GVars.atlasData.hasReset = false
	#Advances the bunny dialouge by 1 (should be an odd number upon exiting this screen)
	GVars.ifsecondboot += 1
	#If in a layer 2 challenge, resets ascBuff as well and deactivates hell
	print(str(GVars.hellChallengeInit))
	if(GVars.hellChallengeLayer2 >= 0) and GVars.hellChallengeInit:
		print("WAYO")
		GVars.resetR1Stats()
		GVars.hellChallengeInit = false
	GVars.sigilData.costSpin = 300 - GVars.atlasData.dumpRustMilestone * 5
	get_tree().change_scene_to_file("res://Scenes/WheelSpace.tscn")


func _hide_all():
	#just hides all buttons
	fear.hide()
	cold.hide()
	warmth.hide()
	wrath.hide()
	complacent.hide()
	awaken.hide()
	challenge.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#advances the background animation
	if(frames < 200):
		frames += 1
		modulate = Color(frames/200,frames/200,frames/200)
	#both if commands seperate 2 different animations which stop upon reaching a certain amount of frames
	if(frames > 300) and (frames < 2400):
		frames += 1
		scale = Vector2(float(frames)/300,float(frames)/300)
