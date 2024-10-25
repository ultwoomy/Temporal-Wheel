extends Node
# Global Script.


#@ Signals


#@ Enumerators
enum Challenges {
	FABULOUS,
}


#@ Constants


#@ Public Variables
## TODO: Replace GVars' currentChallenges with this one.
##  - Make sure to put this in save/load.
##  - Make sure to put this in hard reset.
var currentChallenges : Array[ChallengeStrategy] = [FabulousCStrat.new()]


#@ Private Variables


#@ Virtual Methods
func _ready() -> void:
	# TESTING PURPOSES
	startChallenges()


#@ Public Methods
func startChallenges() -> void:
	for challenge in currentChallenges:
		challenge._execute()


func addChallenge(newChallenge : Challenges) -> void:
	var challengeStrategy : ChallengeStrategy = _getChallengeStrategyFromChallenge(newChallenge)
	currentChallenges.append(challengeStrategy)


#@ Private Methods
func _getChallengeStrategyFromChallenge(challenge : Challenges) -> ChallengeStrategy:
	match challenge:
		Challenges.FABULOUS:
			return FabulousCStrat.new()
		_:
			printerr("ERROR: Challenge given does not exist!")
			return null
