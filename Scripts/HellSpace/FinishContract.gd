extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.hellChallengeLayer2 >= 0):
		show()
	else:
		hide()



func _on_pressed():
	if(GVars.hellChallengeLayer2 == 0):
		GVars.hellChallengeLayer2 = -1
		GVars.hellChallengeNerf = -1
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif(GVars.hellChallengeLayer2 == 1):
		GVars.hellChallengeLayer2 = -1
		GVars.hellChallengeNerf = -1
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif(GVars.hellChallengeLayer2 == 2):
		GVars.hellChallengeLayer2 = -1
		GVars.hellChallengeNerf = -1
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif(GVars.hellChallengeLayer2 == 3):
		GVars.hellChallengeLayer2 = -1
		GVars.hellChallengeNerf = -1
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
