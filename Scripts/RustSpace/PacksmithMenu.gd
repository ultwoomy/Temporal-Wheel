extends Control
class_name PacksmithMenu


#@ Export Variables


#@ Public Variables
var currentState : PacksmithMenuState = PickState.new(self)  # We start in the pick state menu, and give it a reference to this node/script.

var inspecting	: bool = false
var ifinmen 	: bool = false
var augmenting	: bool = false
#var inmenu = false  # L.B: What is the point of this?
var upgrading	: bool = false
var automating	: bool = false
var line = 0
var mode = 0
var sigilToActivate = 0
var packscript = ["That's my sigil.",
				  "All sigils are kind of like...\npermissions of sorts.",
				  "All this one does is let you\ntalk to me.",
				  "...Stop looking disappointed\nit's a high honor!",
				
				  "A lovely candle.",
				  "It's sufficient to light any\nspace.",
				  "You'll likely be able to see\nthings back home you \ncouldn't before",
				
				  "Looks like a portal or\nsomething.",
				  "Not sure exactly what it does\nbut.",
				  "It's attached itself to your\nwheel",
				  "Clicking on the wheel should\ntell you more.",
				
				  "A vague memory of a face.",
				  "It's honestly kind of creepy\nthat you have this.",
				  "Wearing this will amplify an\nemotion of your choice\nto a considerable degree.",
				  "To the point where it persists\nafter death.",
				  "...You'd have to wear it\nthough.\nEw.",
				
				  "A relic from hell, the\nritual.",
				  "It represents a deal with\nthe devil, though the\ndevil happens to be dead.",
				  "So it's peculiar that this\nis working at all.",
				  "Maybe a new one spawned in.",
				
				  "Oh hey, it's the sigil of a\nblue baby.",
				  "Those things are the\nservants of Divine.",
				  "You could probably use this\nto get into heaven!",
				  "...actually there's no perm\nfor that in here.\nGuess it's useless then.",
				
				  "Now it's a rust magnet.",
				  "You should get more rust\nfrom that wheel now.",
				
				  "I've increased the strength\n of the light.",
				  "The warm glow should make\nshrooms grow twice as\nfast.",
				  "Which makes no sense since\nthey like dim lighting.",
				
				  "I don't think I know enough\nto touch this.",
				  "Lemme just uh.",
				  "Oops.",
				  "It seems to be sucking in\nmomentum at an increased\nrate.",
				  "I barely touched it I swear.",
				
				  "I'm not entirely sure what\nyou want me to do with this.",
				  "You're going to wear that?\nReally?.",
				  "...",
				  "It uh, looks good on you\nI think?",
				
				  "This one's easy, I can just\nreplace one of these\ncandles with one of mine.",
				  "Now the first candle you\nLight is free.",
				  "I'm not giving you any more.",
				
				  "There's a powerful contract\netched into this sigil.",
				  "I can start this contract\nfor you, but be warned.",
				  "This thing is tough, even\nstarting it requires\neverything you've gotten\nup till now.",
				  "It will invert the effect\nof your current emotion\nturning it into a debuff.",
				  "What exactly that is...\nEh, you'll find out.",
				  "This will persist until\nyou regain this sigil\nand augment it again.",
				  "If you don't want to\ndo this yet, it's ok\nto just leave.",
				  "Alright, good luck.",
				
				  "There's a powerful contract\netched into this sigil.",
				  "I can start this contract\nfor you, but...",
				  "You've already finished it\nsomehow. Huh.",
				  "Well good for you, you've\nbeen updated.",
				  "Go ahead and try entering\nhell now.",
				
				  "I can draw out the power\nof the blue babies and\nmake you immortal!!",
				  "It's not implemented yet so\nI don't have to explain\nshit."]
var endofline = [false,false,false,true,
				 false,false,true,
				 false,false,false,true,
				 false,false,false,false,true,
				 false,false,false,true,
				 false,false,false,true,
				 false,true,
				 false,false,true,
				 false,false,false,false,true,
				 false,false,false,true,
				 false,false,true,
				 false,false,false,false,false,false,false,true,
				 false,false,false,false,true,
				 false,true]
var emote = [2,2,2,3, # inspect packsmith sigil
			 2,2,2, # inspect candle sigil
			 4,2,2,2, # inspect ascension sigil
			 2,4,2,4,5, # inspect emptiness sigil
			 2,2,2,2, # inspect ritual sigil
			 2,2,2,2, # inspect hell sigil
			 2,2, # augment packsmith sigil
			 2,2,3, # augment candle sigil
			 2,2,4,4,2, # augment ascension sigil
			 2,4,5,2, # augment emptiness sigil
			 4,2,5, # augment ritual sigil
			 2,2,4,2,2,2,2,1, # augment hell sigil(?)
			 2,2,4,2,1,
			 3,0]
			
var convoNo = [0,4,7,11,16,20,24,26,29,34,38,41,49,54,0]
var convoStart = false
var pos = 0


#@ Private Variable
var dialogueHandler : DialogueHandler = DialogueHandler.new()


#@ Onready Variables
@onready var inspectButton : Button = $InspectButton
@onready var augmentButton : Button = $AugmentButton
@onready var upgradeButton : Button = $UpgradeButton
@onready var automateButton : Button = $AutomateButton
@export var text : Label  # L.B - WIP: Remove from Packsmith (OUTSIDE PacksmithMenu)

@onready var selectionMenu : SelectionMenu = $SelectionMenu
@onready var upgradeMenu : UpgradeMenu = $UpgradeMenu

@onready var automationMenu : Sprite2D = $AutomationMenu

#@export var upgrade1 : Button  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var upgrade2 : Button  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var upgrade3 : Button  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var upgrade4 : Button  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var up1text : Label  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var up2text : Label  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var up3text : Label  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var up4text : Label  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var rDisplay : Label  # L.B - WIP: Remove from Packsmith, put into Upgrade Menu
#@export var sigilDisplay : AnimatedSprite2D  # L.B - WIP: Remove from Packsmith (OUTSIDE PacksmithMenu)
@export var next : Button
@export var packback :AnimatedSprite2D  # L.B - WIP: Remove from Packsmith (OUTSIDE PacksmithMenu)


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	# Run current state's enter, since it is the first state which isn't ran in changeState().
	currentState._enter()
	
#	rDisplay.position = Vector2(-190,0)
#	rDisplay.text = str(GVars.getScientific(GVars.rustData.rust))
#	inspectButton.size = Vector2(400,50)
#	inspectButton.position = Vector2(100,100)
#	augmentButton.size = Vector2(400,50)
#	augmentButton.position = Vector2(100,150)
#	upgradeButton.size = Vector2(400,50)
#	upgradeButton.position = Vector2(100,200)
#	automateButton.size = Vector2(400,50)
#	automateButton.position = Vector2(100,250)
	
#	inspectButton.text = "Inspect"
#	augmentButton.text = "Augment"
#	upgradeButton.text = "Upgrade"
#	automateButton.text = "Automate"
	
	upgradeMenu.hide()
	if (GVars.hellChallengeNerf > 0) or (GVars.ifhell):
		automateButton.show()
	else:
		automateButton.hide()
	automationMenu.hide()
	
#	upgrade1.size = Vector2(350,150)
#	upgrade1.position = Vector2(15,-50)
#	upgrade2.size = Vector2(350,150)
#	upgrade2.position = Vector2(-50,-50)
#	upgrade3.size = Vector2(350,150)
#	upgrade3.position = Vector2(-50,35)
#	upgrade4.size = Vector2(350,150)
#	upgrade4.position = Vector2(15,35)
#	upgrade1.text = "Increase Spin Per Click"
#	upgrade2.text = "Increase Hunger Per Tick"
#	upgrade3.text = "Increase Rust Per Drop"
#	if(GVars.curEmotionBuff < 0) or (GVars.curEmotionBuff > 4):
#		upgrade4.hide()
#	elif(GVars.curEmotionBuff == 1):
#		#fear
#		upgrade4.text = "Increase Wheel Spin Rate Per\nRotation"
#	elif(GVars.curEmotionBuff == 2):
#		#cold
#		upgrade4.text = "Increase Hunger By Percentage\nOf Momentum Needed For\nNext Size"
#	elif(GVars.curEmotionBuff == 3):
#		#warmth
#		upgrade4.text = "Increase Mushroom\nExperience Gain"
#	elif(GVars.curEmotionBuff == 4):
#		#wrath
#		upgrade4.text = "Increase Effect Of Rust\nUpgrades"
#	up1text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseSpinCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseSpin))
#	up2text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseHungerCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseHunger))
#	up3text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.increaseRustCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.increaseRust))
#	up4text.text = "Cost: " + str(GVars.getScientific(GVars.rustData.fourthCost)) + "\nCurrent Multiplier: " + str(GVars.getScientific(GVars.rustData.fourth))
#	upgrade1.pressed.connect(self._up01)
#	upgrade2.pressed.connect(self._up02)
#	upgrade3.pressed.connect(self._up03)
#	upgrade4.pressed.connect(self._up04)

#	next.size = Vector2(100,100)
#	next.position = Vector2(390,420)
#	next.text = "Next"
	next.hide()
	
#	inspectButton.pressed.connect(self._inspect)
#	augmentButton.pressed.connect(self._augment)
#	upgradeButton.pressed.connect(self._upgrade)
#	automateButton.pressed.connect(self._automate)
	
	if(!GVars.sigilData.numberOfSigils[0]):
		inspectButton.hide()
		augmentButton.hide()
		upgradeButton.hide()
		automateButton.hide()
		text.text = "No shirt, no sigil, no service."
	
	### PacksmithSelectionMenu's buttons.
#	selectionMenu.sigil_button_pressed.connect(_on_sigil_button_pressed)
	###
	
	next.pressed.connect(self.nextLine)
	selectionMenu.hide()
#	updateDisplays()
	
	dialogueHandler.dialogueFilePath = "res://JSON/Dialogue/Packsmith/PacksmithInspect.json"
	print("dialogueHandler.getDialogueData(\"packsmith\") = ", dialogueHandler.getDialogueData("packsmith"))


func _process(delta: float) -> void:
	# currentState's _update() function should be called every frame to act like _process().
	if currentState:
		currentState._update(delta)


#@ Public Methods
func changeState(newState : PacksmithMenuState) -> void:
	# Call currentState's exit function before changing it.
	if currentState:
		currentState._exit()
	
	# Change currentState to newState w/ the same init variables, and call its enter function.
	currentState = newState
	currentState._enter()


func nextLin(m):
	GVars._dialouge(text,0,0.04)
	if convoStart:  # L.B: This is always false!
		pos = convoNo[m]
		text.text = packscript[pos]
		packback.frame = emote[pos]


func nextLine():
	GVars._dialouge(text,0,0.04)
	if endofline[pos]: # L.B: This lets dialogue know when to stop.
		pos = 0
		text.text = ""
		packback.frame = 2
		resetChoice()
		if(sigilToActivate != 0):
			resetDisplay(sigilToActivate)
			sigilToActivate = 0
	else: 
		pos += 1
		text.text = packscript[pos]
		packback.frame = emote[pos]


#func _inspect():
#	inspecting = true
#	# If inspect button is pressed, then show the contents.
#	if(ifinmen == false):
#		dispSigils()
#		ifinmen = true
##		inmenu = true
#	# If the button is pressed again, then hide the content.
#	else:
#		selection.hide()
#		ifinmen = false
##		inmenu = false


#func _augment():
#	inspecting = false
#	if(augmenting == false):
#		dispSigils()
#		augmenting = true
##		inmenu = true
#	else:
#		selectionMenu.hide()
#		augmenting = false
##		inmenu = false


#func dispSigils():
#	selectionMenu.show()
#
#	selectionMenu.display_sigils()
#
#	upgradeMenu.hide()
#	automationMenu.hide()
#	resetWindowVars()


#func _upgrade():
#	if(upgrading == false):
#		upgradeMenu.show()
#		selectionMenu.hide()
#		automationMenu.hide()
#		resetWindowVars()
#		upgrading = true
#		automating = false
##		inmenu = true
#	else:
#		upgradeMenu.hide()
#		upgrading = false
##		inmenu = false


#func _automate():
#	if(automating == false):
#		automationMenu.show()
#		selectionMenu.hide()
#		upgradeMenu.hide()
#		resetWindowVars()
#		automating = true
#		upgrading = false
##		inmenu = true
#	else:
#		automationMenu.hide()
#		automating = false
##		inmenu = false


#func _on_sigil_button_pressed(sigil: SigilData.Sigils) -> void:
#	match sigil:
#		SigilData.Sigils.PACKSMITH:
#			manageChoice(1)
#		SigilData.Sigils.CANDLE:
#			manageChoice(2)
#		SigilData.Sigils.ASCENSION:
#			manageChoice(3)
#		SigilData.Sigils.EMPTINESS:
#			manageChoice(4)
#		SigilData.Sigils.RITUAL:
#			manageChoice(5)
#		SigilData.Sigils.HELL:
#			manageChoice(6)


#func resetWindowVars():
#	inmenu = false
#	upgrading = false
#	augmenting = false
#	ifinmen = false


func resetChoice():
	text.text = ""
	packback.frame = 2
	line = 0
#	resetWindowVars()
	inspectButton.show()
	augmentButton.show()
	upgradeButton.show()
	if(GVars.hellChallengeNerf > 0) or (GVars.ifhell):
		automateButton.show()
	next.hide()


#func manageChoice(n):
#	GVars._dialouge(text,0,0.04)
#	selectionMenu.hide()
#	inspectButton.hide()
#	augmentButton.hide()
#	upgradeButton.hide()
#	automateButton.hide()
#	next.show()
#	text.show()
#	if(inspecting):
#		if(n == 1):
#			nextLin(0)
#		elif(n == 2):
#			nextLin(1)
#		elif(n == 3):
#			nextLin(2)
#		elif(n == 4):
#			nextLin(3)
#		elif(n == 5):
#			nextLin(4)
#		elif(n == 6):
#			nextLin(5)
#	if(!inspecting):
#		if(n == 1):
#			nextLin(6)
#			sigilToActivate = 1
#		elif(n == 2):
#			nextLin(7)
#			sigilToActivate = 2
#		elif(n == 3):
#			nextLin(8)
#			sigilToActivate = 3
#		elif(n == 4):
#			nextLin(9)
#			sigilToActivate = 4
#		elif(n == 5):
#			nextLin(10)
#			sigilToActivate = 5
#		elif(n == 6):
#			if(GVars.hellChallengeNerf < 0):
#				if(!GVars.ifhell):
#					nextLin(11)
#					sigilToActivate = 6
#				else:
#					nextLin(13)
#					sigilToActivate = 6
#			else:
#				nextLin(12)
#				sigilToActivate = 6
#				GVars.ifhell = true
#				GVars.inContract = false
#				GVars.hellChallengeNerf = -1


func resetDisplay(n: int):
	sigilToActivate = 0
	if(n == 6) and !GVars.ifhell:
		GVars.sigilData.curSigilBuff = n
		get_tree().change_scene_to_file("res://Scenes/AscensionSpace.tscn")
	GVars.sigilData.curSigilBuff = n
#	sigilDisplay.frame = GVars.sigilData.curSigilBuff - 1
#	sigilDisplay.show()
	


