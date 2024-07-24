extends Control


#@ Signals
signal dialogueCompleted


#@ Public Variables
var dialogueLine : int = 0
var dialouge : Array[String] = ["Welcome you cat thing, to the underground.",
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
var spritebody : Array[int] = [1,1,1,1,1,1,0,1,1,0,1,0,1,1,1,1,1,1]
var spriteface : Array[int] = [1,2,1,2,0,2,1,0,1,2,1,2,1,2,1,2,1,2]
var ifend : Array[bool] = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true]


#@ Onready Variables
@onready var zundaBodySprite : AnimatedSprite2D = $ZundaBody
@onready var zundaFaceSprite : AnimatedSprite2D = $ZundaFace
@onready var dialogueBox : Sprite2D = $DialogueBox
@onready var nextButton : Button = $NextButton
@onready var dialogueLabel : Label = $DialogueLabel


#@ Private Methods
func _onNextPressed():
	dialogueLine += 1
	if(!ifend[dialogueLine]):
		GVars._dialouge(dialogueLabel,0,0.02)
		dialogueLabel.text = dialouge[dialogueLine]
		dialogueLabel.show()
		zundaBodySprite.frame = spritebody[dialogueLine]
		zundaFaceSprite.frame = spriteface[dialogueLine]
	else:
		self.hide()
		dialogueCompleted.emit()
		GVars.ifFirstHell = false
