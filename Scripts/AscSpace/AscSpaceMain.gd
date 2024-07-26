extends GameScene


#@ Constants


#@ Public Variables
var newChallenge : ChallengeData
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
		GVars.setChallengeDataInChallenges(newChallenge)
		GVars.inContract = true
		GVars.curEmotionBuff = 0
	elif switchEmotionBuff == 199:
		GVars.setChallengeDataInChallenges(newChallenge)
		GVars.inContract = true
		GVars.hellChallengeInit = true
	else:
		GVars.curEmotionBuff = switchEmotionBuff
	awakenButton.show()


func _onChallengeButtonPressed() -> void:
	match newChallenge:
		# Layer 1
		GVars.CHALLENGE_INCONGRUENT: _onGenericButtonPressed(99,"feel incongruent.\n\nYou've made a terrible mistake.\nIt will be different this time.")
		GVars.CHALLENGE_BRAVE: _onGenericButtonPressed(99,"feel brave.\n\nYou are ready to go back.\nIt will be different this time.")
		GVars.CHALLENGE_SHARP: _onGenericButtonPressed(99,"feel sharp.\n\nAs if hundreds of needles\nare poking your skin.\nIt will be different this time.")
		GVars.CHALLENGE_AWARE: _onGenericButtonPressed(99,"feel aware.\n\nAs if you've snapped out\na tired trance.\nIt will be different this time.")
		GVars.CHALLENGE_CALM: _onGenericButtonPressed(99,"feel calm.\n\nYou shove your way through\nthe deep.\nIt will be different this time.")
		# Layer 2
		GVars.CHALLENGE_SANDY: _onGenericButtonPressed(199,"feel sandy.\n\nIt's course and gritty and\ngets everywhere.")
		GVars.CHALLENGE_BITTERSWEET: _onGenericButtonPressed(199,"feel bittersweet.\n\nThe world is so beautiful\nyou want to cry.")
		GVars.CHALLENGE_STARVED: _onGenericButtonPressed(199,"feel starved.\n\nIt's eating you up on the\ninside.")
		GVars.CHALLENGE_FABULOUS: _onGenericButtonPressed(199,"feel fabulous.\n\nIt's time to slay, in one\nway or another.")
		# Error
		_: _onGenericButtonPressed(199,"Not good.\n\nError in the code.\nContinuing will half\nreset your save.")


# L.B: COPIED AND PASTED CODE - I don't know what this is doing.
func _awaken():
	GVars.Aspinbuff = GVars.mushroomData.ascBuff + GVars.ritualData.ascBuff  # TODO: Replace this with a global variable in Buffs.gd
	GVars.resetR0Stats()
	GVars.atlasData.hasReset = false
	#Advances the bunny dialouge by 1 (should be an odd number upon exiting this screen)
	GVars.ifSecondBoot += 1
	
	#If in a layer 2 challenge, resets ascBuff as well and deactivates hell
	print(str(GVars.hellChallengeInit))
	if GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.SECOND) and GVars.hellChallengeInit:
		print("WAYO")
		GVars.resetR1Stats()
		GVars.hellChallengeInit = false
	GVars.sigilData.costSpin = 300 - GVars.atlasData.dumpRustMilestone * 5
	
	GVars.setChallengeToCurrentChallenges()
	
	SceneHandler.changeSceneToFilePath(SceneHandler.WHEELSPACE)


func _displayDialogue() -> void:
	storyLabel.text = "You find yourself\nat an endless ocean."
	GVars._dialouge(storyLabel, 0, 0.05)
	storyLabel.text += "\n\nIt calls to you."
	storyLabel.text += "\n\nYou feel..."


func _displayButtons() -> void:
	#If face is active, show emotion
	#Cannot stack emotion with challenge of the same type
	if GVars.sigilData.curSigilBuff == 3:
		if not GVars.hasChallengeActive(GVars.CHALLENGE_INCONGRUENT):
			fearButton.show()
		if not GVars.hasChallengeActive(GVars.CHALLENGE_BRAVE):
			coldButton.show()
		if not GVars.hasChallengeActive(GVars.CHALLENGE_SHARP):
			warmthButton.show()
		if not GVars.hasChallengeActive(GVars.CHALLENGE_AWARE):
			wrathButton.show()
	
	#If hell sigil is active and hell is not unlocked, show challenge options based on emote buff
	#Nothing prepared for no emote buff, shouldn't be easy or possible to get
	if (GVars.sigilData.curSigilBuff == 5) and not GVars.ifhell:
		challengeButton.show()
		if GVars.curEmotionBuff <= 0:
			newChallenge = GVars.CHALLENGE_INCONGRUENT
		elif GVars.curEmotionBuff == 1:
			newChallenge = GVars.CHALLENGE_BRAVE
		elif GVars.curEmotionBuff == 2:
			newChallenge = GVars.CHALLENGE_SHARP
		elif GVars.curEmotionBuff == 3:
			newChallenge = GVars.CHALLENGE_AWARE
		elif GVars.curEmotionBuff == 4:
			newChallenge = GVars.CHALLENGE_CALM
		challengeButton.text = newChallenge.name
	
	#If a second layer challenge is activated and there is no first layer challenge
	#Show the unfinished meme challenges
	#Does not actually start them until until exiting screen, is currently abusable by exiting the game during this cutscene
	var onlySecondLayerChallengeActive : bool = GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.SECOND) and not GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.FIRST)
	if onlySecondLayerChallengeActive and GVars.hellChallengeInit:
		GVars.hellChallengeInit = false
		
		newChallenge = GVars.currentChallenges[ChallengeData.ChallengeLayer.SECOND]
		
		challengeButton.text = newChallenge.name
		challengeButton.show()
	
	complacencyButton.show()
