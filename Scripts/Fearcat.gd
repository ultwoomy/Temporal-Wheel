extends AnimatedSprite2D
@export var nextButton : Button
@export var giftButton : Button
@export var text : Label
@export var desc : Label
@export var ribbon : Sprite2D
@export var extraEffect : Label
var timeOfDay = 0
var line = 0
var speechDay = ["It's a new day. Hello world.",
				 "Don't be shy little kit, fly closer.",
				 "Our meeting today is a blessing, perhaps you'll care for a cup of tea?"]
var speechNight = ["What are you doing here? Get out! It's dark!",
				   "No it's too late for that. Just stay in the corner. Don't touch me.",
				   "You can stay until the night ends just don't make any noise.",
				   "You'll learn how to stay out of sight."]
var speechDayGift =   ["Hmm? What's this?",
					   "A pretty little bow, just for me?",
					   "How lovely. I'll wear it now."]
var speechNightGift = ["Gifts? Now is most certainly not the time!",
					   "Not when she's still searching about."]
var dayEmotes = [3,4,5]
var nightEmotes = [2,1,0,1]

func _ready():
	nextButton.hide()
	giftButton.hide()
	desc.hide()
	if GVars.ifSecondBoot % 4 == 3 or GVars.ifSecondBoot % 4 == 0:
		if GVars.ifFirstFearcatNight:
			desc.hide()
			nextButton.show()
			timeOfDay = 0
			text.text = speechNight[0]
			frame = nightEmotes[0]
			GVars._dialouge(text,0,0.01)
		else:
			text.text = "Shh! Quiet! She might be listening!"
			GVars._dialouge(text,0,0.01)
			frame = 0
			desc.show()
			if not GVars.fearcatData.hasBow:
				giftButton.show()
	else:
		if GVars.ifFirstFearcatNight:
			desc.hide()
			nextButton.show()
			timeOfDay = 1
			text.text = speechDay[0]
			frame = dayEmotes[0]
			GVars._dialouge(text,0,0.04)
		else:
			text.text = "Back for a visit little one? It's good to see you again."
			GVars._dialouge(text,0,0.04)
			frame = 3
			desc.show()
			if not GVars.fearcatData.hasBow:
				giftButton.show()
	if GVars.fearcatData.hasBow:
		ribbon.show()
		extraEffect.show()
	else:
		ribbon.hide()
		extraEffect.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if timeOfDay == 0:
		line += 1
		if line == speechNight.size():
			nextButton.hide()
			text.text = "Shh! Quiet! She might be listening!"
			GVars._dialouge(text,0,0.01)
			frame = 0
			desc.show()
			nextButton.hide()
			GVars.ifFirstFearcatDay = false
			line = 0
			if not GVars.fearcatData.hasBow:
				giftButton.show()
		else:
			text.text = speechNight[line]
			frame = nightEmotes[line]
			GVars._dialouge(text,0,0.01)
	if timeOfDay == 1:
		line += 1
		if line == speechDay.size():
			nextButton.hide()
			text.text = "Back for a visit little one? It's good to see you again."
			GVars._dialouge(text,0,0.04)
			frame = 3
			nextButton.hide()
			desc.show()
			GVars.ifFirstFearcatNight = false
			line = 0
			if not GVars.fearcatData.hasBow:
				giftButton.show()
		else:
			text.text = speechDay[line]
			frame = dayEmotes[line]
			GVars._dialouge(text,0,0.04)
	if timeOfDay == 2:
		if line == speechNightGift.size():
			nextButton.hide()
			text.text = "Shh! Quiet! She might be listening!"
			GVars._dialouge(text,0,0.01)
			frame = 0
			line = 0
			nextButton.hide()
			desc.show()
			if not GVars.fearcatData.hasBow:
				giftButton.show()
		else:
			text.text = speechNightGift[line]
			frame = nightEmotes[line]
			GVars._dialouge(text,0,0.01)
		line += 1
	if timeOfDay == 3:
		if line == speechDayGift.size():
			nextButton.hide()
			text.text = "Back for a visit little one? It's good to see you again."
			GVars._dialouge(text,0,0.04)
			frame = 3
			line = 0
			nextButton.hide()
			desc.show()
			GVars.backpackData.ribbon = false
			GVars.fearcatData.hasBow = true
			if not GVars.fearcatData.hasBow:
				giftButton.show()
			if GVars.fearcatData.hasBow:
				ribbon.show()
				extraEffect.show()
		else:
			text.text = speechDayGift[line]
			frame = dayEmotes[line]
			GVars._dialouge(text,0,0.04)
		line += 1
		


func _on_ribbon_gift_pressed():
	giftButton.hide()
	desc.hide()
	nextButton.show()
	if GVars.ifSecondBoot % 4 == 3 or GVars.ifSecondBoot % 4 == 0:
		timeOfDay = 2
	else:
		timeOfDay = 3
	_on_button_pressed()
	


func _on_back_button_pressed():
	SceneHandler.changeSceneToFilePath(SceneHandler.HELLSPACE)
