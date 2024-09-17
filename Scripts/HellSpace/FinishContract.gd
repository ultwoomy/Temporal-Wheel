extends Button
var hellSigil : Sigil = load("res://Resources/Sigil/HellSigil.tres")

#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.sigilData.acquiredSigils.has(hellSigil)):
		show()
	else:
		hide()


#@ Private Methods
func _on_pressed():
	if GVars.challenges.has(GVars.CHALLENGE_SANDY):
		GVars.challenges = []
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.challenges.has(GVars.CHALLENGE_BITTERSWEET):
		GVars.challenges = []
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.challenges.has(GVars.CHALLENGE_STARVED):
		GVars.challenges = []
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
		GVars.nightChallengeData.resetData()
		hide()
	elif GVars.challenges.has(GVars.CHALLENGE_FABULOUS):
		GVars.challenges = []
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
