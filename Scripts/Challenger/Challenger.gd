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
var currentChallenges : Array[ChallengeStrategy] = []


#@ Private Variables


#@ Virtual Methods
func _ready() -> void:
	# TESTING PURPOSES
	EventManager.thorn_disconnect_complete.connect(self.refresh)
	currentChallenges.clear()
	for x in GVars.currentChallenges:
		if x != null:
			addChallenge(x)
	startChallenges()

func refresh():
	currentChallenges.clear()

#@ Public Methods
func startChallenges() -> void:
	for challenge in currentChallenges:
		if challenge != null:
			challenge._execute()


func addChallenge(newChallenge : ChallengeData) -> void:
	if GVars.hasChallengeActive(GVars.CHALLENGE_FABULOUS): # Temporarily just check if the activated challenge is fab
		var challengeStrategy : ChallengeStrategy = _getChallengeStrategyFromChallenge(newChallenge)
		currentChallenges.append(challengeStrategy)


#@ Private Methods
func _getChallengeStrategyFromChallenge(challenge : ChallengeData) -> ChallengeStrategy:
	match challenge:
		GVars.CHALLENGE_FABULOUS:
			return FabulousCStrat.new()
		_:
			printerr("ERROR: Challenge given does not exist!")
			return null
