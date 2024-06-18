extends AnimatedSprite2D
@export var zundabody : AnimatedSprite2D
@export var zundaface : AnimatedSprite2D
@export var text : Label
@export var textbox : Sprite2D
@export var nextButton : Button
@export var openCPage : Button
var line = 0
var dialouge = ["Welcome you cat thing, to the underground.",
				"How was the fall?",
				"No idea how you got here, but while you're here.",
				"Listen, I need some help.",
				"As the ruler of hell, I'm supposed to process souls and stuff, I think.",
				"The problem is I already took like all of the ones here.",
				"And stored them safely in my belly.",
				"So here's the deal. I open a portal to an alternate dimension, and you grab all the living things there.",
				"These alternate universes usually have some weird modifier to make things difficult",
				"Dunno why. For the sake of the narrative probably.",
				"We'll split them 50/50. So whaddya say?",
				"What are you supposed to do with those? You can just spend them at my shop.",
				"So in the end it all goes to me. How's that for queen of hell?",
				"Oh and, before I forget, this isn't a baby contract like the one you just did.",
				"This will reset your identity bonus. And your ability to get here too.",
				"You'll have to do that whole thing again to unlock this place.",
				"For your trouble, I'll give you new sigils.",
				"Try not to get them stolen by rabbit fae."]
				
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
		GVars.ifFirstHell = false
		
func skip_opener():
		openCPage.show()
		textbox.hide()
		text.hide()
		nextButton.hide()
		zundabody.hide()
		zundaface.hide()
		openCPage.show()


func _on_right_pressed():
	if GVars.ifFirstHell:
		openCPage.hide()
		GVars._dialouge(text,0,0.02)
		text.text = dialouge[0]
	else:
		skip_opener()
