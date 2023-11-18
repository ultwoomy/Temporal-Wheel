extends Node
@export var text : Label
@export var button : Button
@export var sigilDisplay : AnimatedSprite2D
var fmat = preload("res://Scripts/FormatNo.gd")
var failbought
var stupids
# Called when the node enters the scene tree for the first time.
func _ready():
	stupids = 0
	sigilDisplay.hide()
	text.position = Vector2(450,300)
	button.size = Vector2(100,100)
	button.position = Vector2(800,370)
	reset()
	button.pressed.connect(self._button_pressed)

func _button_pressed():
	GVars._dialouge(text,0,0.02)
	if(failbought):
		reset()
	else :
		if((GVars.spin > GVars.sigilCostSpin) && (GVars.rotations > GVars.sigilCostRot)):
			#GVars.spin -= GVars.sigilCostSpin
			#GVars.rotations -= GVars.sigilCostRot
			GVars.sigilCostSpin = pow(GVars.sigilCostSpin,GVars.sigilCostSpinScale)
			GVars.sigilCostRot *= GVars.sigilCostRotScale
			var curSigil = 0
			while GVars.numberOfSigils[curSigil]:
				curSigil += 1
			if(curSigil == 0):
				text.text = "The Packsmith's token!\nUse it to make that grumpy\nold so and so do business\nwith you!"
			elif(curSigil == 1):
				text.text = "A warm candle!\nLights up your entire universe!"
			elif(curSigil == 2):
				text.text = "Reincarnation Ascension!\nI don't know what this does!\nMysteries are fun!"
			elif(curSigil == 3):
				text.text = "Emptiness!\nExtremely ironic name!\nFull of emoticon!"
			else :
				text.text = "Use it well!"
			GVars.numberOfSigils[curSigil] = true
			button.text = "Thx"
			sigilDisplay.show()
			sigilDisplay.frame = curSigil
			failbought = true
		else :
			if(stupids == 0):
				text.text = "You can't afford that stupid."
				stupids += 1
			elif(stupids == 1):
				text.text = "Guess what? You can't afford that."
				stupids += 1
			elif(stupids == 2):
				text.text = "Yup. Still broke."
				stupids += 1
			elif(stupids == 3):
				text.text = "Not much has changed."
				stupids += 1
			elif(stupids == 4):
				text.text = "You still can't afford that."
				stupids += 1
			elif(stupids == 5):
				text.text = "And you're still stupid."
				stupids += 1
			elif(stupids == 6):
				text.text = "Kidding! You can afford that now!"
				stupids += 1
			elif(stupids == 7):
				text.text = "Not really."
				stupids += 1
			elif(stupids == 8):
				text.text = "But one day you will."
				stupids += 1
			elif(stupids == 9):
				text.text = "Maybe."
				stupids += 1
			elif(stupids == 10):
				text.text = "Do you like secrets?"
				stupids += 1
			elif(stupids == 15):
				text.text = "I think you like secrets."
				stupids += 1
			elif(stupids == 20):
				text.text = "You must have a lot of free time."
				stupids += 1
			elif(stupids == 21):
				text.text = "Good for you. It doesn't last."
				stupids += 1
			elif(stupids == 22):
				text.text = "Unless you literally make time."
				stupids += 1
			elif(stupids == 23):
				text.text = "Now I'm the stupid one."
				stupids += 1
			elif(stupids == 24):
				text.text = "This doesn't make you less broke."
				stupids += 1
			elif(stupids == 25):
				text.text = "Just vaguely annoying."
				stupids += 1
			elif(stupids == 30):
				text.text = "I'm going to stop you here."
			else:
				text.text = "I like secrets!"
				stupids += 1
			button.text = "Oh"
			failbought = true
		
func reset():
	if(GVars.numberOfSigils[3]):
		text.text = "We're out lmao."
		button.hide()
	else :
		text.text = "Here for a sigil?\nIt'll cost ya:\n" + str(GVars.getScientific(GVars.sigilCostSpin)) + " momentum\n" + str(GVars.getScientific(GVars.sigilCostRot)) + " rotations"
		button.text = "Buy"
		failbought = false

