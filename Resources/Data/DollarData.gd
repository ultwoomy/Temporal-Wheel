extends Resource
class_name DollarData

@export var achievementsCompleted : int
var achievementList : Array[Achievement]
var sandDollars : float

@export var insuranceCost : float
@export var insuranceScaling : float
@export var insuranceAmtSpin : float
@export var insuranceAmtRot : float
@export var insuranceAmtRust : float
@export var insuranceAmtSpinUp : float
@export var insuranceAmtRotUp : float
@export var insuranceAmtRustUp : float

func _init():
	resetData()

func resetData() -> void:
	achievementsCompleted = 0
	sandDollars = 0
	# First parameter is achievement name
	# Second parameter is achievement description
	# Third parameter is variable checked 
	# Fourth parameter is comparision method
		# 0 is equal to
		# 1 is less than
		# 2 is more than
		# 3 is less than or equal to
		# 4 is more than or equal to
		# 5 is true
		# 6 is false
	# Fifth parameter is value to be checked against
	# Sixth parameter is sand dollar reward value
	var temp = Achievement.new()
	temp.setAchievement("Helloo", "Click this box for a sand dollar. First one's free!", "spin", 4, 0, 1)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Momentum", "This one's not as free. Needs 10000 momentum", "spin", 4, 10000, 1)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Cheddar", "Get the cheese from the rats", "ratmail", 4, 2, 1)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("A friend?", "Meet Atlas", "ifFirstAtlas", 6, null, 1)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Just a doll", "Have a current presence of 7 or more", "Aspinbuff", 4, 5, 5)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("A friend??", "Meet Fearcat", "ifFirstFearcatNight", 6, null, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("A friend!", "Meet Warmcat", "ifFirstFearcatDay", 6, null, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Shards of self", "Have a current presence of 16 or more", "Aspinbuff", 4, 16, 5)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Faster, Faster!", "A lotta speed. Needs 10000000 momentum", "spin", 4, 10000000, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("There's no time", "Have less than 10 rotations", "rotations", 3, 10, 3)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("There's time", "Ooh I got plenny of time. More than 1000 rotations", "rotations", 4, 1000, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("A bit rusty", "Have more than 1000 rust", "rust", 4, 1000, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Little trinkets", "Get the drum from the rats", "ratmail", 4, 8, 1)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Mushroom Mushroom", "SNAAAAAKE. Mushroom level of 8 or more.", "mushlevel", 4, 8, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Eons of growth", "This is taking a while. Mushroom level of 10 or more.", "mushlevel", 4, 10, 2)
	achievementList.append(temp)
	temp = Achievement.new()
	temp.setAchievement("Brilliant Lightning", "Very speed. Needs 1000000000 momentum", "spin", 4, 1000000000, 4)
	achievementList.append(temp)
	resetDollar()
	
func resetDollar():
	insuranceCost = 2
	#additive scaling
	insuranceScaling = 3
	insuranceAmtSpin = 100
	insuranceAmtRot = 10
	#multiplicative scaling
	insuranceAmtSpinUp = 3
	#additive scaling
	insuranceAmtRotUp = 10
	insuranceAmtRust = 10
	#multiplicative scaling
	insuranceAmtRustUp = 2
