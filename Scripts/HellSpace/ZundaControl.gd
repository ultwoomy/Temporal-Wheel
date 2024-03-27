extends AnimatedSprite2D
@export var zundabody : AnimatedSprite2D
@export var zundaface : AnimatedSprite2D
@export var text : Label
@export var textbox : Sprite2D
@export var nextButton : Button
@export var openCPage : Button
var line = 0
var dialouge = ["Hey! It's me Goku!",
				"And I rule over hell!",
				"No idea how you got here, but while you're here.",
				"Listen, I need some help.",
				"As the ruler of hell, I'm supposed to process\nsouls and stuff.",
				"The problem is I can't get any, they're too\nfast for me to catch.",
				"You have wings so you would have more luck\ngetting them.",
				"So here's the deal. I open a portal to an alternate\ndimension, and you catch all the souls there.",
				"These alternate universes usually have some weird\nmodifier to make things difficult",
				"Dunno why. For the sake of the narrative probably.",
				"We'll split them 50/50. So whaddya say?",
				"What are you supposed to do with those?\nYou can just spend them at my shop.",
				"So in the end it all goes to me. How's that\n for queen of hell?",
				"Oh and, before I forget, this isn't a baby\ncontract like the one you just did.",
				"This will reset your identity bonus. And\nyour hell permission.",
				"You'll have to talk to the Packsmith again\nto unlock this place.",
				"Then get back here again again and that's it.",
				"Do things!"]
				
var spritebody = [1,1,1,1,1,1,0,1,1,0,1,0,1,1,1,1,1,1]
var spriteface = [1,2,1,2,0,2,1,0,1,2,1,2,1,2,1,2,1,2]
var ifend = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true]

func _on_next_pressed():
	line += 1
	if(!ifend[line]):
		GVars._dialouge(text,0,0.02)
		text.text = dialouge[line]
		text.show()
		zundabody.frame = spritebody[line]
		zundaface.frame = spriteface[line]
	else:
		skip_opener()
		GVars.iffirsthell = false
		
func skip_opener():
		openCPage.show()
		textbox.hide()
		text.hide()
		nextButton.hide()
		zundabody.hide()
		zundaface.hide()
		openCPage.show()


func _on_right_pressed():
	if GVars.iffirsthell:
		openCPage.hide()
		GVars._dialouge(text,0,0.02)
		text.text = dialouge[0]
	else:
		skip_opener()
