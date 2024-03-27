extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.hellChallengeLayer2 > 0):
		show()
	else:
		hide()



func _on_pressed():
	if(GVars.hellChallengeNerf == 10):
		GVars.hellChallengeNerf = -1
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls += 20
	elif(GVars.hellChallengeNerf == 11):
		GVars.hellChallengeNerf = -1
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls += 20
	elif(GVars.hellChallengeNerf == 12):
		GVars.hellChallengeNerf = -1
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
	elif(GVars.hellChallengeNerf == 13):
		GVars.hellChallengeNerf = -1
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls += 20
