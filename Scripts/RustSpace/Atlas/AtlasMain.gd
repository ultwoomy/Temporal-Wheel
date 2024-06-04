extends AnimatedSprite2D
@export var text : Label
@export var next : Button
@export var dump : Button
@export var panel : Panel
@export var reset : Button
var currentLine = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if GVars.iffirstatlas:
		frame = 0
		GVars._dialouge(text,0,0.01)
		text.text = "Finally\n         Yes finally\n    You \n       Keeper of Time\n           You've come to me."
		next.show()
		panel.hide()
		dump.hide()
		reset.hide() 
	else:
		normalBoot()

var lines = ["I hold up the sky\n      I devour the ground\n            I am Atlas.",
			 "I eat and eat\nSo that one day\n                  She\nMay eat me as well.",
			 "You will feed me\n                 And I will feed you\n     And we will both grow and grow.",
			 "She will not forget you.\nYou are blessed\nYou are blessed\nYou are blessed\nYou are blessed"]
var sprite = [0,2,1,0,2]
func _on_next_pressed():
	if(currentLine >= lines.size()):
		normalBoot()
		GVars.iffirstatlas = false
	else:
		GVars._dialouge(text,0,0.01)
		text.text = lines[currentLine]
		frame = sprite[currentLine]
		currentLine += 1
		
func normalBoot():
	next.hide()
	dump.show()
	panel.show()
	if(GVars.atlasData.dumpRustMilestone > 0):
		reset.show()
	else:
		reset.hide()
	updatePanel()
	GVars._dialouge(text,0,0.01)
	if not GVars.atlasData.hasReset:
		reset.text = "Reset spins needed till next rust drop\nCurrently: " + str(GVars.getScientific(GVars.rustData.thresh)) + " rotations per drop\nYou can only reset once per run."
	else:
		reset.text = "You have already reset."
		reset.disabled = true
	text.text = "Today\n           you bring\n     More?"


func _on_dump_pressed():
	if(GVars.atlasData.dumpRustMilestone <= 10):
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
			frame = 1
			reset.show()
		elif GVars.atlasData.dumpRustMilestone == 2:
			GVars._dialouge(text,0,0.01)
			text.text = "By spin\n   Your rust grows\n    I will grow your spin for you."
			frame = 1
		elif GVars.atlasData.dumpRustMilestone == 4:
			GVars._dialouge(text,0,0.01)
			text.text = "Your anger is much\n   much\n      much\n         too weak\nI will help you."
			frame = 2
		else:
			GVars._dialouge(text,0,0.01)
			text.text = "You are blessed."
			frame = 1
	else:
		GVars._dialouge(text,0,0.01)
		text.text = "Joyful!\n    But not enough\n           Not enough."
		frame = 2
	updatePanel()
		
func updatePanel():
	panel.get_child(0).text = "Milestones: " + str(GVars.atlasData.dumpRustMilestone)
	if(GVars.atlasData.dumpRustMilestone > 0):
		panel.get_child(0).text += "\n\nUnlocks reset scaling."
	if(GVars.atlasData.dumpRustMilestone > 1):
		panel.get_child(0).text += "\n\nYou gain " + str(GVars.atlasData.dumpRustMilestone/4 + 1) + " free density"
	if(GVars.atlasData.dumpRustMilestone > 3):
		panel.get_child(0).text += "\n\nYou gain a " + str(GVars.atlasData.dumpRustMilestone + 1) + " rust multiplier when the current emotion is wrath"
	if(GVars.atlasData.dumpRustMilestone >= 5):
		dump.text = "You've reached the softcap for this update."
	elif(GVars.atlasData.dumpRustThresh <= GVars.atlasData.dumpRustProg):
		dump.text = "Press me for the\nnext milestone"
	else:
		dump.text = "Dump rust\nValue to next milestone: " + str(GVars.getScientific(GVars.atlasData.dumpRustThresh - GVars.atlasData.dumpRustProg))


func _on_reset_scaling_pressed():
	reset.text = "You have already reset."
	GVars.atlasData.hasReset = true
	GVars.rustData.thresh = 1
	reset.disabled = true
