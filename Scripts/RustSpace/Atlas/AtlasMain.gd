extends GameScene


#@ Export Variables


#@ Onready Variables
@onready var atlasSprite : AnimatedSprite2D = $AtlasSprite
@onready var text : Label = $Label
@onready var nextButton : Button = $NextButton
@onready var backButton : BaseButton = $BackButton
@onready var dumpButton : Button = $DumpButton
@onready var milestonePanel : Panel = $MilestonePanel
@onready var resetButton : Button = $ResetButton


#@ Public Variables
var currentLine = 0


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	if GVars.ifFirstAtlas:
		atlasSprite.frame = 0
		GVars._dialouge(text,0,0.01)
		text.text = "Finally\n         Yes finally\n    You \n       Keeper of Time\n           You've come to me."
		nextButton.show()
		milestonePanel.hide()
		dumpButton.hide()
		resetButton.hide() 
	else:
		normalBoot()


var lines = ["I hold up the sky\n      I devour the ground\n            I am Atlas.",
			 "I eat and eat\nSo that one day\n                  She\nMay eat me as well.",
			 "You will feed me\n                 And I will feed you\n     And we will both grow and grow.",
			 "She will not forget you.\nYou are blessed\nYou are blessed\nYou are blessed\nYou are blessed"]
var sprite = [0,2,1,0,2]


func normalBoot():
	nextButton.hide()
	dumpButton.show()
	milestonePanel.show()
	if(GVars.atlasData.dumpRustMilestone > 0):
		resetButton.show()
	else:
		resetButton.hide()
	updatePanel()
	GVars._dialouge(text,0,0.01)
	if not GVars.atlasData.hasReset:
		resetButton.text = "Reset spins needed till next rust drop\nCurrently: " + str(GVars.getScientific(GVars.rustData.thresh)) + " rotations per drop\nYou can only reset once per run."
	else:
		resetButton.text = "You have already reset."
		resetButton.disabled = true
	text.text = "Today\n           you bring\n     More?"


func updatePanel():
	milestonePanel.get_child(0).text = "Milestones: " + str(GVars.atlasData.dumpRustMilestone)
	if(GVars.atlasData.dumpRustMilestone > 0):
		milestonePanel.get_child(0).text += "\n\nUnlocks reset scaling."
	if(GVars.atlasData.dumpRustMilestone > 1):
		milestonePanel.get_child(0).text += "\n\nYou gain " + str(GVars.atlasData.dumpRustMilestone/4 + 1) + " free density"
	if(GVars.atlasData.dumpRustMilestone > 3):
		milestonePanel.get_child(0).text += "\n\nYou gain a " + str(GVars.atlasData.dumpRustMilestone + 1) + " rust multiplier when the current emotion is wrath"
	if(GVars.atlasData.dumpRustMilestone > 6):
		milestonePanel.get_child(0).text += "\n\nReduce initial sigil cost by" + str(GVars.atlasData.dumpRustMilestone * 5) + "momentum"
	if(GVars.atlasData.dumpRustMilestone >= 13):
		dumpButton.text = "You've reached the softcap for this update."
	elif(GVars.atlasData.dumpRustThresh <= GVars.atlasData.dumpRustProg):
		dumpButton.text = "Press me for the\nnext milestone"
	else:
		dumpButton.text = "Dump rust\nValue to next milestone: " + str(GVars.getScientific(GVars.atlasData.dumpRustThresh - GVars.atlasData.dumpRustProg))


#@ Private Methods
func _onNextButtonPressed():
	if(currentLine >= lines.size()):
		normalBoot()
		GVars.ifFirstAtlas = false
	else:
		GVars._dialouge(text,0,0.01)
		text.text = lines[currentLine]
		atlasSprite.frame = sprite[currentLine]
		currentLine += 1


func _onBackButtonPressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.RUSTSPACE_OUTSIDE)


func _onDumpButtonPressed():
	if(GVars.atlasData.dumpRustMilestone <= 13):
		GVars.atlasData.dumpRustProg += GVars.rustData.rust
		GVars.rustData.rust = 0
	if(GVars.atlasData.dumpRustThresh <= GVars.atlasData.dumpRustProg):
		GVars.atlasData.dumpRustProg -= GVars.atlasData.dumpRustThresh
		if GVars.atlasData.dumpRustMilestone < 10:
			GVars.atlasData.dumpRustThresh *= GVars.atlasData.dumpRustScaling
			GVars.atlasData.dumpRustMilestone += 1
		else:
			GVars.atlasData.dumpRustThresh *= GVars.atlasData.dumpRustScaling * 3
			GVars.atlasData.dumpRustMilestone += 1
		if GVars.atlasData.dumpRustMilestone == 1:
			GVars._dialouge(text,0,0.01)
			text.text = "To our happy feeding\n       I grant you\n Greater rust power."
			atlasSprite.frame = 1
			resetButton.show()
		elif GVars.atlasData.dumpRustMilestone == 2:
			GVars._dialouge(text,0,0.01)
			text.text = "By spin\n   Your rust grows\n    I will grow your spin for you."
			atlasSprite.frame = 1
		elif GVars.atlasData.dumpRustMilestone == 4:
			GVars._dialouge(text,0,0.01)
			text.text = "Your anger is much\n   much\n      much\n         too weak\nI will help you."
			atlasSprite.frame = 2
		elif GVars.atlasData.dumpRustMilestone == 7:
			GVars._dialouge(text,0,0.01)
			text.text = "Clicking and clicking and\n       clicking. It must be\n           tiresome.\n I will save you the effort."
			atlasSprite.frame = 1
		else:
			GVars._dialouge(text,0,0.01)
			text.text = "You are blessed."
			atlasSprite.frame = 1
	else:
		GVars._dialouge(text,0,0.01)
		text.text = "Joyful!\n    But not enough\n           Not enough."
		atlasSprite.frame = 2
	updatePanel()


func _onResetButtonPressed():
	resetButton.text = "You have already reset."
	GVars.atlasData.hasReset = true
	GVars.rustData.thresh = 1
	resetButton.disabled = true
