extends Button
var hellSigil : Sigil = load("res://Resources/Sigil/HellSigil.tres")

#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	if(GVars.sigilData.acquiredSigils.has(hellSigil) and not GVars.challenges.is_empty()):
		show()
	else:
		hide()


#@ Private Methods
func _on_pressed():
	if GVars.challenges.has(GVars.CHALLENGE_SANDY):
		GVars.challenges.remove_at(1)
		GVars.soulsData.doubleShroomChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.challenges.has(GVars.CHALLENGE_BITTERSWEET):
		GVars.challenges.remove_at(1)
		GVars.soulsData.doubleRotChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	elif GVars.challenges.has(GVars.CHALLENGE_STARVED):
		GVars.challenges.remove_at(1)
		GVars.soulsData.spinBaseBuffEnabled = true
		GVars.soulsData.souls += 20
		GVars.nightChallengeData.resetData()
		hide()
	elif GVars.challenges.has(GVars.CHALLENGE_FABULOUS):
		GVars.challenges.remove_at(1)
		GVars.soulsData.voidRustChanceEnabled = true
		GVars.soulsData.souls += 20
		hide()
	print(str(GVars.challenges.is_empty()))
