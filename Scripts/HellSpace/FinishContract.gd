extends Button
var hellSigil : Sigil = load("res://Resources/Sigil/HellSigil.tres")

#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	print((GVars.sigilData.acquiredSigils.has(hellSigil)))
	if(GVars.sigilData.acquiredSigils.has(hellSigil) and GVars.doesLayerHaveChallenge(ChallengeData.ChallengeLayer.SECOND)):
		show()
	else:
		hide()


#@ Private Methods
func _on_pressed():
	if GVars.hasChallengeActive(GVars.CHALLENGE_SANDY):
		GVars.currentChallenges.clear()
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.hasChallengeActive(GVars.CHALLENGE_BITTERSWEET):
		GVars.currentChallenges.clear()
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.hasChallengeActive(GVars.CHALLENGE_STARVED):
		GVars.currentChallenges.clear()
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
		GVars.nightChallengeData.resetData()
		hide()
	elif GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS):
		GVars.currentChallenges.clear()
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	print(str(GVars.challenges.is_empty()))
