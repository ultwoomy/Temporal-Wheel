extends GameScene


#@ Constants


#@ Public Variables
var newChallenges : ChallengeData
var challengeNumber : int = -1


#@ Onready Variables
@onready var background : AnimatedSprite2D = $Background
@onready var storyLabel : Label = $Story

@onready var fearButton : Button = $Fear
@onready var coldButton : Button = $Cold
@onready var warmthButton : Button = $Warmth
@onready var wrathButton : Button = $Wrath
@onready var complacencyButton : Button = $Complacency
@onready var awakenButton : Button = $Awaken
@onready var challengeButton : Button = $Challenge


#@ Virtual Methods
func _ready() -> void:
	# Connect signals.
	fearButton.pressed.connect(self._onGenericButtonPressed.bind(1,"feel afraid.\n\nYou try to fly away.\nYou do not escape."))
	coldButton.pressed.connect(self._onGenericButtonPressed.bind(2,"feel cold.\n\nYou can't move as water\nCreeps up your limbs\nswallowing you whole."))
	warmthButton.pressed.connect(self._onGenericButtonPressed.bind(3,"feel warm.\n\nYou willingly embrace the\nwaves.\nYou are crushed."))
	wrathButton.pressed.connect(self._onGenericButtonPressed.bind(4,"feel wrath.\n\nYou strike at the sea\nwith all your might.\nIt's not enough."))
	complacencyButton.pressed.connect(self._onGenericButtonPressed.bind(0,"feel nothing.\n\nYou sink willingly\ninto the deep."))
	awakenButton.pressed.connect(self._awaken)
	challengeButton.pressed.connect(self._onChallengeButtonPressed)
	
	# Visuals.
	updateBackground()
	hideAllButtons()
	await get_tree().create_timer(2.5).timeout
	
	_displayDialogue()
	await get_tree().create_timer(5).timeout
	
	_displayButtons()


#@ Public Methods
func hideAllButtons() -> void:
	fearButton.hide()
	coldButton.hide()
	warmthButton.hide()
	wrathButton.hide()
	complacencyButton.hide()
	awakenButton.hide()
	challengeButton.hide()


func updateBackground() -> void:
	if GVars.curEmotionBuff < 5:
		background.frame = GVars.curEmotionBuff
	else:
		background.frame = 0


#@ Private Methods
func _onGenericButtonPressed(switchEmotionBuff : int, text : String) -> void:
	# Visuals.
	hideAllButtons()
	storyLabel.text = storyLabel.text.left(storyLabel.text.length() - 7)
	background.frame = 5
	background.playAnimation()
	storyLabel.text += text
	GVars._dialouge(storyLabel, 62, 0.05)
	await get_tree().create_timer(5).timeout
	
	# Grants any buffs based on switchEmotionBuff which is granted by emotion chosen.
	#99 is placeholder number for layer 1 challenge, 199 for layer 2
	if switchEmotionBuff == 99:
		' 
		(!!!) L.B: 
			This doesnt implement the code of doing multiple challenges.
			These new changes Ive added only imitate the old code.
			TODO: Actually implement layered challenges.
		'
		GVars.challenges = [newChallenges]
#		GVars.hellChallengeNerf = challengeNumber
		GVars.inContract = true
		switchEmotionBuff = 0
		GVars.curEmotionBuff = 0
	elif switchEmotionBuff == 199:
		GVars.hellChallengeLayer2 = challengeNumber - 10
		GVars.inContract = true
		GVars.hellChallengeInit = true
		switchEmotionBuff = 0
	else:
		GVars.curEmotionBuff = switchEmotionBuff
	awakenButton.show()


func _onChallengeButtonPressed() -> void:
	# L.B: The idea is to do stuff with first layer and then second layer.
	# However, the original code only did stuff when the latest if statement was filled(?).
	# Meaning that previous functionality was overriden by whatever if statement at the end (if the conditions were met).
	# This shows that the code was still incomplete/work in progress.
	# If trying to do something with the idea of doing multiple challenges... maybe do something along the lines of:
#	for challengeData in newChallenges:
#		_matchChallenge(challengeData)
	
	_matchChallenge(newChallenges)


# L.B: COPIED AND PASTED CODE - I don't know what this is doing.
func _awaken():
	GVars.Aspinbuff = GVars.mushroomData.ascBuff + GVars.ritualData.ascBuff  # TODO: Replace this with a global variable in Buffs.gd
	GVars.resetR0Stats()
	GVars.atlasData.hasReset = false
	#Advances the bunny dialouge by 1 (should be an odd number upon exiting this screen)
	GVars.ifSecondBoot += 1
	#If in a layer 2 challenge, resets ascBuff as well and deactivates hell
	print(str(GVars.hellChallengeInit))
	if (GVars.hellChallengeLayer2 >= 0) and GVars.hellChallengeInit:
		print("WAYO")
		GVars.resetR1Stats()
		GVars.hellChallengeInit = false
	GVars.sigilData.costSpin = 300 - GVars.atlasData.dumpRustMilestone * 5
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)


func _displayDialogue() -> void:
	storyLabel.text = "You find yourself\nat an endless ocean."
	GVars._dialouge(storyLabel,0,0.05)
	storyLabel.text += "\n\nIt calls to you."
	storyLabel.text += "\n\nYou feel..."


func _displayButtons() -> void:
	#If face is active, show emotion
	#Cannot stack emotion with challenge of the same type
	if GVars.sigilData.curSigilBuff == 3:
		if not GVars.hasChallenge(GVars.INCONGRUENT):
			fearButton.show()
		if not GVars.hasChallenge(GVars.BRAVE):
			coldButton.show()
		if not GVars.hasChallenge(GVars.SHARP):
			warmthButton.show()
		if not GVars.hasChallenge(GVars.AWARE):
			wrathButton.show()
	
	#If hell sigil is active and hell is not unlocked, show challenge options based on emote buff
	#Nothing prepared for no emote buff, shouldn't be easy or possible to get
	
	# testing purposes:
	GVars.sigilData.curSigilBuff = 5
	GVars.hellChallengeLayer2 = 0
#	GVars.hellChallengeNerf = -1
	GVars.hellChallengeInit = true
	
	
	if (GVars.sigilData.curSigilBuff == 5) and not GVars.ifhell:
		challengeButton.show()
		if GVars.curEmotionBuff <= 0:
			newChallenges = GVars.INCONGRUENT
#			challengeNumber = 0
		elif GVars.curEmotionBuff == 1:
			newChallenges = GVars.BRAVE
#			challengeNumber = 1
		elif GVars.curEmotionBuff == 2:
			newChallenges = GVars.SHARP
#			challengeNumber = 2
		elif GVars.curEmotionBuff == 3:
			newChallenges = GVars.AWARE
#			challengeNumber = 3
		elif GVars.curEmotionBuff == 4:
			newChallenges = GVars.CALM
#			challengeNumber = 4
		challengeButton.text = newChallenges.name
	
	#If a second layer challenge is activated and there is no first layer challenge
	#Show the unfinished meme challenges
	#Does not actually start them until until exiting screen, is currently abusable by exiting the game during this cutscene
	if not GVars.challenges and GVars.hellChallengeInit:
		challengeButton.show()
		if GVars.hellChallengeLayer2 == 0: 
			newChallenges = GVars.SANDY
			GVars.hellChallengeInit = false
#			challengeNumber = 10
		elif GVars.hellChallengeLayer2 == 1:
			newChallenges = GVars.BITTERSWEET
			GVars.hellChallengeInit = false
#			challengeNumber = 11
		elif GVars.hellChallengeLayer2 == 2:
			newChallenges = GVars.STARVED
			GVars.hellChallengeInit = false
#			challengeNumber = 12
		elif GVars.hellChallengeLayer2 == 3:
			newChallenges = GVars.FABULOUS
			GVars.hellChallengeInit = false
#			challengeNumber = 13
		challengeButton.text = newChallenges.name
	
	complacencyButton.show()


func _matchChallenge(challenge : ChallengeData) -> void:
	match challenge:
		# Layer 1
		GVars.INCONGRUENT: _onGenericButtonPressed(99,"feel incongruent.\n\nYou've made a terrible mistake.\nIt will be different this time.")
		GVars.BRAVE: _onGenericButtonPressed(99,"feel brave.\n\nYou are ready to go back.\nIt will be different this time.")
		GVars.SHARP: _onGenericButtonPressed(99,"feel sharp.\n\nAs if hundreds of needles\nare poking your skin.\nIt will be different this time.")
		GVars.AWARE: _onGenericButtonPressed(99,"feel aware.\n\nAs if you've snapped out\na tired trance.\nIt will be different this time.")
		GVars.CALM: _onGenericButtonPressed(99,"feel calm.\n\nYou shove your way through\nthe deep.\nIt will be different this time.")
		# Layer 2
		GVars.SANDY: _onGenericButtonPressed(199,"feel sandy.\n\nIt's course and gritty and\ngets everywhere.")
		GVars.BITTERSWEET: _onGenericButtonPressed(199,"feel bittersweet.\n\nThe world is so beautiful\nyou want to cry.")
		GVars.STARVED: _onGenericButtonPressed(199,"feel starved.\n\nIt's eating you up on the\ninside.")
		GVars.FABULOUS: _onGenericButtonPressed(199,"feel fabulous.\n\nIt's time to slay, in one\nway or another.")
		# Error
		_: _onGenericButtonPressed(199,"Not good.\n\nError in the code.\nContinuing will half\nreset your save.")
