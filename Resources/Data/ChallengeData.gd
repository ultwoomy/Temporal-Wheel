extends Resource
class_name ChallengeData


#@ Enumerators
enum ChallengeLayer {
	FIRST,
	SECOND,
}

#@ Export Variables
@export var name : String
@export var layer : ChallengeLayer  # Determines the index this ChallengeData resource will be in the GVars.challenges/GVars.currentChallenges array.
