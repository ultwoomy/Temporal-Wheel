extends Node
var achievementsDisplayed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	displayAchievables()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func returnComparisionVar(x):
	if x == "spin":
		return GVars.spinData.momentum
	elif x == "ifFirstAtlas":
		return GVars.ifFirstAtlas
	elif x == "ifFirstFearcatDay":
		return GVars.ifFirstFearcatDay
	elif x == "ifFirstFearcatNight":
		return GVars.ifFirstFearcatNight
	elif x == "rotations":
		return GVars.spinData.rotations
	elif x == "mushlevel":
		return GVars.mushroomData.level
	else:
		return 0
		
func displayAchievables():
	achievementsDisplayed = 0
	for i in GVars.dollarData.achievementList:
		if i.filled:
			#Skip whatever display thing here
			pass
		elif i.checkComparable(returnComparisionVar(i.type)):
			#Do whatever display thing here
			achievementsDisplayed += 1
		if achievementsDisplayed == 10:
			break
