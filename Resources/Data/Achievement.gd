extends Node
class_name Achievement
var achievementName : String
var description : String
var filled : bool
var type : String
var targetValue
var rewardDollars : int
var comparision : int
# In what way should I check the passed value against the target value
# 0 is equal to
# 1 is less than
# 2 is more than
# 3 is less than or equal to
# 4 is more than or equal to
# 5 is true
# 6 is not


func setAchievement(Aname, desc, typ, comp, value, reward):
	achievementName = Aname
	description = desc
	filled = false
	type = typ
	comparision = comp
	targetValue = value
	rewardDollars = reward
func checkComparable(comparable):
	if filled:
		return true
	if comparision == 0:
		if comparable == targetValue:
			return true
	if comparision == 1:
		if comparable < targetValue:
			return true
	if comparision == 2:
		if comparable > targetValue:
			return true
	if comparision == 3:
		if comparable <= targetValue:
			return true
	if comparision == 4:
		if comparable >= targetValue:
			return true
	if comparision == 5:
		if comparable:
			return true
	if comparision == 6:
		if not comparable:
			return true
