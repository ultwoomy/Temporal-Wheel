extends Resource
class_name ChallengeData


#@ Enumerators
enum ChallengeLayer {
	FIRST,
	SECOND,
}

#@ Export Variables
@export var name : String
@export var layer : ChallengeLayer
