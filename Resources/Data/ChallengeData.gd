extends Resource
class_name ChallengeData


#@ Enumerators
enum ChallengeLayer {
	FIRST,
	SECOND,
}

enum FirstLayerChallenges {
	INCONGRUENT,
	BRAVE,
	SHARP,
	AWARE,
	CALM,
}

enum SecondLayerChallenges {
	SANDY,
	BITTERSWEET,
	STARVED,
	FABULOUS,
}

#@ Export Variables
@export var name : String
@export var layer : ChallengeLayer
