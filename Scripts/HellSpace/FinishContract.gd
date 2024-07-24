extends Button


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.hellChallengeLayer2 >= 0):
		show()
	else:
		hide()


#@ Private Methods
func _on_pressed():
	if GVars.hellChallengeLayer2 == 0:
		GVars.challenges = []
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.hellChallengeLayer2 == 1:
		GVars.challenges = []
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.hellChallengeLayer2 == 2:
		GVars.challenges = []
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.hellChallengeLayer2 == 3:
		GVars.challenges = []
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
